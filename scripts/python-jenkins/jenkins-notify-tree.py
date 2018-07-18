#!/usr/bin/python
import argparse
import jenkins
import os
import subprocess
import sys

outFile = 'summary.html'
printString = ''
header = "<html>\n<center>\n<font size=\"6\" color=\"blue\" face=\"verdana\">\n<b>Builds Status</b>\n</font>\n</center>\n<br><br>\n<body>\n<font face=\"verdana\">\n<table align=\"center\" border=\"3\" cellpadding=\"5\">\n<font size=\"3\" face=\"verdana\"><tr><td>Job Name</td><td>Parameters</td><td>Result</td></tr>\n"
footer = '\n</table>\n</body>\n</html>'

printParams = ['CURRENT_RELEASE', 'OUTPUT_DIR','FEATURE', 'MODE', 'BUILD_DIR', 'PLATFORM', 'ISO_TEMPLATE_DIR', 'RELEASE_TAG', 'NFS_DIR', 'EXPORT_DIR', 'BRANCH_NAME', 'BUILD_DIRECTORY', 'FORCE_CREATE']

def connect_to_jenkins(url_link, user, passw):
    url = url_link
    username = user
    password = passw
    server = jenkins.Jenkins(url, username, password)
    return server

def execCmd(cmd):
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
    (output, error) = p.communicate()
    p_status = p.wait()
    #print "execCmd: ", output
    return output, error

def print_dict_keys(dictInfo):
    #print dictInfo
    for key, value in dictInfo.iteritems():
        print key
    return # Nothing

def get_build_info(server, job, buildNum):
    #print "inside get_build_info():", buildNum
    buildInfo = server.get_build_info(job, buildNum)
    for i,dic in enumerate(buildInfo['actions']):
        if 'parameters' in dic:
            params = buildInfo['actions'][i]['parameters']
    return buildNum, buildInfo['url'], params, buildInfo['result']

def write_to_file(fileName, string, mode='w'):
    try:
        fp = open(fileName, mode)
        fp.write(string)
        fp.close()
        return True
    except IOError as e:
        #log.error("Can not open file '%s' for writing", fileName)
        return False

def search_pattern(filename, searchstr):
    datafile = file(filename)
    for line in datafile:
        if searchstr in line:
            return True, line
    return False, None

def search_special(filename):
    retval,line = search_pattern(filename, "Generated build/upgrade.tar.gz.out")
    if retval:
        #print "Found upgrader"
        return "built_upgrader=True"
    retval,line = search_pattern(filename, "Registered AMI image id")
    if retval:
        #print "Found AMI ID"
        return line
    #print "Found Nothing"
    return False

def populate_subprojects(server, jobname, jobnum):
    buildnum, buildurl, buildparams, result = get_build_info(server, jobname, jobnum)
    consoleurl = buildurl + 'consoleText'
    command = 'curl ' + consoleurl + ' > console.txt' #| tail -20 | egrep "completed. Result was "'
    consoleOutput,err = execCmd(command)
    specialParam = search_special('console.txt')
    #Print each project to html here
    this = '<tr><td>' + jobname + '(%s)' % buildnum + '</td>'
    this = this + '<td>'
    if specialParam:
        this = this + specialParam + ',\n'
        print specialParam

    if 'built_upgrader' not in str(specialParam):
        for i,parameters in enumerate(buildparams):
            if parameters['name'] in printParams:
                this = this + parameters['name'] + '=' + str(parameters['value']) + ',\n'

    this = this + '</td>'
    this = this + '<td>' + str(result) + '</td></tr>'
    write_to_file(outFile, this, 'a')

    #get the list of subprojects:
    command = 'cat console.txt ' + ' | egrep "completed. Result was (SUCCESS|FAILURE)"'
    consoleOutput,err = execCmd(command)
    os.remove('console.txt')
    if err:
        return #No subprojects found in log
    lines = consoleOutput.rstrip().split('\n')
    lines = filter(lambda name: name.strip(), lines)
    #print "lines=", lines
    for line in lines:
        print "Job:=", line
        tmpList = line.split('#')
        jobName = tmpList[0].strip()
        jobNum = int(tmpList[1].split(' ')[0].strip())
        #jobResult = str(tmpList[1].split(' ')[4].strip())
        populate_subprojects(server, jobName, jobNum)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate notifications')
    parser.add_argument('--jenkinsurl', required=True, help="URL of Jenkins Server")
    parser.add_argument('--username', required=True, help="Jenkins user")
    parser.add_argument('--password', required=True, help="Jenkins user password")
    parser.add_argument('--masterjobname', required=True, help="Master Job from where subjobs will be populated")
    parser.add_argument('--masterjobnumber', required=True, help="Job number of the master job")
    parser.add_argument('--paramsforprint', default='BRANCH_NAME', help="Comma separated parameters. It appends parameters to list of default printParams")
    args = parser.parse_args()
    printParams = printParams + str(args.paramsforprint).split(',')
    print printParams
    server = connect_to_jenkins(str(args.jenkinsurl), str(args.username), str(args.password))
    write_to_file(outFile, header, 'w')
    populate_subprojects(server, str(args.masterjobname), int(args.masterjobnumber))
    write_to_file(outFile, footer, 'a')

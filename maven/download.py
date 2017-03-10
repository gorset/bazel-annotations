import os
import sys
import urllib
import hashlib

outputFile, url, sha1 = sys.argv[1:]

response = urllib.urlopen(url)
if response.getcode() != 200:
    print>>sys.stderr, "Bad response %s from server for %s" % (response.getcode(), url)
    sys.eixt(1)
data = response.read()

dataSha1 = hashlib.sha1(data).hexdigest()
if sha1 != dataSha1:
    print>>sys.stderr, "expected sha1 '%s' but got sha1 '%s' for %s" % (sha1, dataSha1, url)
    sys.exit(1)

outputDir = os.path.dirname(outputFile)
if not os.path.exists(outputDir):
    os.makedirs(outputDir)
with open(outputFile, 'w') as fd:
    fd.write(data)

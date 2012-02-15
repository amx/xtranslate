#!/usr/bin/python
import httplib, urllib, re, sys
#for t in sys.argv: 	print t
#print	sys.argv[2]
#exit()

def getPhrase():
    return sys.argv[3]

def getsLang():
    return sys.argv[1]

def gettLang():
    return sys.argv[2]

def retrieve(host, path):
    request = httplib.HTTPConnection(host)
    request.request("GET", path, "", {'User-Agent' : 'Mozilla/5.0'})
    response = request.getresponse()
    if response.status > 200:
        return '[["{}"],"ERROR"]'.format(response.reason)
    return response.read()

def parse_item(item, depth = 0):
    if type(item) is str:
        if len(item) == 0:
            return ''
        return ("\t" * depth) + item + "\n"
    result = ''
    for sub_item in item:
        result += parse_item(sub_item, depth + 1)
    return result

phrase = getPhrase()
tlang = gettLang()
slang = getsLang()

host = 'translate.google.com'
URL = 'translate_a/t?client=t&sl=' + slang + '&tl=' + tlang + '&' + urllib.urlencode({'text' : phrase})

response = re.sub(',{2,}', ',', retrieve(host, "/" + URL))
try:
    translated = eval(response)
    result = ''
    for item in translated:
        if type(item) is str:
            result = "Translation: " + slang + " > " + tlang + "\n\n" + result
            break
        result += parse_item(item, -1)
    print result
except RuntimeError as ex:
    print "Something went wrong ({}): {}".format(response, ex)

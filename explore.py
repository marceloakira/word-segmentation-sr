from googlesearch import search
from urllib.parse import urlparse
f = open("/tmp/search.csv", "w+")
count = 0
for i in search(query='"word segmentation" "natural language processing" nlp -chinese -urdu -thai -vietnamese -myanmar -khmer -arabic -jobs -tibetan -ad -medical -"call for papers"', stop=100):
    count += 1
    o = urlparse(i)
    f.write(str(count)+'| '+str(i)+'|'+o.hostname+'|\n')
f.close()


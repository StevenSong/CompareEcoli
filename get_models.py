#!/usr/bin/env python
#
# Steven Song
# 3 May 2019
# COMP 150CSB
# get_models.py - TODO

import sys
import os
import requests

base = 'http://bigg.ucsd.edu/'

def main(argv):
  dir = 'models'
  if not os.path.exists(dir):
    os.makedirs(dir)

  if len(argv) != 1:
    exit(1)

  search = argv[0]

  model_names = [x['bigg_id'] for x  in requests.get(base + 'api/v2/search?query=' + search + '&search_type=models').json()['results']]
  
  print('Downloading the following models (' + str(len(model_names)) + ' models):')
  
  for model_name in model_names:
    print(model_name)
    filename = dir + '/' + model_name + '.mat'

    if not os.path.exists(filename):
      model = requests.get(base + 'static/models/' + filename).content
      open(filename, 'wb').write(model)

if __name__ == '__main__':
  main(sys.argv[1:])
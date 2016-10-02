travis-solr
===========

Script to setup Solrcloud testing environment on travis-ci.


How use it
==========

```bash
before_script:
  - curl -s https://raw.githubusercontent.com/yriveiro/travis-solr/master/install.sh | SOLR_VERSION=6.2.1 bash
```

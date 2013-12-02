travis-solr
===========

Script to setup Solrcloud testing environment on travis-ci.


How use it
==========

```bash
before_script:
  - curl -s  https://raw.github.com/yriveiro/travis-solr/master/travis-solr.sh | SOLR_VERSION=4.6.0 bash
```

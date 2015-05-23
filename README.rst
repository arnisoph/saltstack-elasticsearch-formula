===============================
saltstack-elasticsearch-formula
===============================


.. image:: https://img.shields.io/badge/flattr-donate-red.svg
    :alt: Donate via flattr
    :target: https://flattr.com/profile/bechtoldt

.. image:: https://img.shields.io/gratipay/bechtoldt.svg
    :alt: Donate via Gratipay
    :target: https://www.gratipay.com/bechtoldt/

.. image:: https://img.shields.io/badge/license-Apache--2.0-blue.svg
    :alt: Apache-2.0-licensed
    :target: https://github.com/bechtoldt/saltstack-elasticsearch-formula/blob/master/LICENSE

.. image:: https://img.shields.io/badge/gitter-chat-brightgreen.svg
    :alt: Join Chat
    :target: https://gitter.im/bechtoldt/saltstack-elasticsearch-formula?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

SaltStack Formula to set up and configure Elasticsearch, a distributed restful search and analytics server

.. contents::
    :backlinks: none
    :local:


Instructions
------------

Please refer to https://github.com/bechtoldt/formula-docs to learn how to use
this formula, how it is built and how you can add your changes.

**NOTICE:** This formula might uses the formhelper module which is a very useful Salt execution module that isn't available
in upstream yet. Please consider retrieving it manually from https://github.com/bechtoldt/salt-modules and
make it available to your Salt installation. Read `SaltStack documentation <http://docs.saltstack.com/en/latest/ref/modules/#modules-are-easy-to-write>`_ to
see how this can be achieved.

Take a look at older `releases <https://github.com/bechtoldt/saltstack-elasticsearch-formula/releases>`_ to get a version that isn't using the formhelper
yet (if any).


Contributing
------------

Contributions are welcome! All development guidelines we ask you to follow can
be found at https://github.com/bechtoldt/formula-docs.

In general:

1. Fork this repo on Github
2. Add changes, test them, update docs (README.rst) if possible
3. Submit your pull request (PR) on Github, wait for feedback

But it’s better to `file an issue <https://github.com/bechtoldt/saltstack-elasticsearch-formula/issues/new>`_ with your idea first.


Authors
-------

* Arnold Bechtoldt <mail@arnoldbechtoldt.com>
* Keith Grennan <keith@nearlyfree.org>
* Michael Riedmann <michael_riedmann@live.com>
* The Gitter Badger <badger@gitter.im>
* Tim O'Guin <tim.oguin@juiceanalytics.com>
* Tyler Mandry <tmandry@gmail.com>


TODO
----

* add instructions how to use formhelper, add information about it in the formula-docs (dependency), show up alternative?
* table/ matrix: os/salt compatibility (dedicated file)
* add list of available states
* add tests


Miscellaneous
-------------

Recommended formulas:

* Logstash management: `saltstack-logstash-formula <https://github.com/bechtoldt/saltstack-logstash-formula>`_
* Kibana user interface management: `saltstack-kibana-formula <https://github.com/bechtoldt/saltstack-kibana-formula>`_
* Java deployment: `saltstack-java-formula <https://github.com/bechtoldt/saltstack-java-formula>`_
* sysctl configuration: `saltstack-sysctl-formula <https://github.com/bechtoldt/saltstack-sysctl-formula>`_
* repo management: `saltstack-repos-formula <https://github.com/bechtoldt/saltstack-repos-formula>`_

Further reading:

* Documentation and Standardisation of SaltStack formulas: https://github.com/bechtoldt/formula-docs

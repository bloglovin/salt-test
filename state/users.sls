{# make sure all users are configured on minion #}

{# imports #####################################}

{# dependencies ################################}
include:
  - ssh

{# attributes ##################################}
{%- set name = sls.split('.')[::-1][0] %}
{%- set ns = '/' + slspath + '/' + name %}
{%- set users = salt['pillar.get']('users') %}

{# main ########################################}

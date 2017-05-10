{# Install latest package and manage config #}

{# imports #####################################}

{# dependencies ################################}

{# attributes ##################################}
{%- set name = sls.split('.')[::-1][0] %}
{%- set ns = '/' + slspath + '/' + name %}

{# main ########################################}

{{ ns }}/install:
  pkg.latest:
    - name: openssh-server

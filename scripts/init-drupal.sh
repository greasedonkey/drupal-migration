#!/bin/bash
# Use this script to setup a fresh Drupal installation

# This command will abort if Drupal is already installed
drupal site:install standard \
  --langcode="en" \
  --db-type="mysql" \
  --db-host="db" \
  --db-name="drupaldb" \
  --db-user="root" \
  --db-pass="complexpassword" \
  --db-port="3306" \
  --db-prefix="" \
  --site-name="Drupal 8 Migration Training" \
  --site-mail="admin@pspc.ca" \
  --account-name="admin" \
  --account-mail="admin@pscp.ca" \
  --account-pass="passw0rd"
  
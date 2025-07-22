#!/bin/bash
# Script to promote DR region by restoring RDS from the latest snapshot.
# Usage: ./promote-dr.sh <dr-region> <snapshot-arn> <db-instance-identifier>

set -e

DR_REGION=$1 # The region where the DR instance will be created
SNAPSHOT_ARN=$2 # The ARN of the snapshot to restore from
DB_INSTANCE_ID=$3 # The identifier for the new DB instance
DB_SUBNET_GROUP=$4 # The DB subnet group to use for the new instance

aws rds restore-db-instance-from-db-snapshot \
  --region $DR_REGION \
  --db-instance-identifier $DB_INSTANCE_ID \
  --db-snapshot-identifier $SNAPSHOT_ARN \
  --db-subnet-group-name $DB_SUBNET_GROUP \
  --publicly-accessible \
  --multi-az
{%- set instance_name = 'preview-prod-chat-ause1-glb-aha1' %}
{%- set profile = 'symphony-aws-prod' %}
{%- set region  = 'us-east-1' %}

{%- set describe_instance_cmd =
    'aws ec2 describe-instances' ~
    ' --profile ' ~ profile ~
    ' --region ' ~ region ~
    ' --filters "Name=tag:Name,Values=' ~ instance_name ~ '" ' ~
    ' --query "Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==\`Name\`]|[0].Value}"' %}

{%- set snapshot_id = 'snap-066877671789bd71b' %}
{%- set availability_zone = 'us-east-1a' %}

{%- set create_volume_cmd =
    'aws ec2 create-volume' ~
    ' --profile ' ~ profile ~
    ' --region ' ~ region ~
    ' --volume-type gp2' ~
    ' --snapshot-id ' ~ snapshot_id ~
    ' --availability-zone ' ~ availability_zone %}

test_describe_instance_run:
  cmd.run:
    - name: echo {{ describe_instance_cmd }}

test_create_volume_run:
  cmd.run:
    - name: echo {{ create_volume_cmd }}

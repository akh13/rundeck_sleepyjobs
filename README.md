# rundeck_sleepyjobs

This script enables A Rundeck user to enable or disable a series of jobs via the API.

## Instructions

* Fill in the auth token, domain, and server URL variables in the sleepyjobs.sh file
* Put a list of job IDs, one per line, in rdjobs.txt
* run the script. You will be prompted, asking if you want to enable or disable the execution

## How do I get an API token in Rundeck?

Log into Rundeck and click your username in the upper-right corner. Enter your profile settings.
When you enter your profile settings, you will see a section that is entitled "User API Tokens."
Click the + sign next to this. Fill in the expiration, roles, and user for the token.

NOTE: ACL requires toggle_schedule action for each job. If you do not have this ACL permission,
stuff gets denied.

## How do I know if this worked?

Once you submit by telling the script if you want to enable/stop execution, you will see the 
result from the server. It will contain a toggleSchedule element with two sections. One lists the
successfull changes. the Other lists failures. It looks a little like this:

``` xml
<toggleSchedule enabled="true" requestCount="#" allsuccessful="true/false">
    <succeeded count="1">
        <toggleScheduleResult id="[job ID]">
            <message>[message]</message>
        </toggleScheduleResult>
    </succeeded>
    <failed count="1">
        <toggleScheduleResult id="[job ID]" errorCode="[code]">
            <error>[message]</error>
        </toggleScheduleResult>
    </failed>
</toggleSchedule>
```


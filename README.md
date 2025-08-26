# PostAsyncGCooldown

This is a very very basic way of enforcing Discord rate limits meant for fairly small games. it enforces a global cool down (2 seconds across all servers)
this is not a Queue any request sent during cooldown will be lost

I kind of coded this as a Fail-Safe in case somebody finds a vulnerability in UTPRC to spam webhooks.

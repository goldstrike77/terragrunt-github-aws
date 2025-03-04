This Terraform runbook will create the landing zone for a startup to begin building on Amazon Web Services. It will create the following resources:
&nbsp;
|IAM|Network|Compliance|
|:---|:---|:---|
||VPCs<br>DHCP option sets<br>Subnets<br>Elastic IPs<br>Transit gateways<br>Internet gateways<br>NAT gateways<br>Route tables<br>Security groups|CloudTrail|

&nbsp;
#### Network solution overview
This architecture shows you how to use AWS Transit Gateway to centralize outbound internet traffic from multiple VPCs using hub-and-spoke design. This design includes two NAT gateways, as illustrated in the following diagram.
<p><img src="https://raw.githubusercontent.com/goldstrike77/terragrunt-github-aws/v0.1/Network.drawio.png" align="right" /></p>
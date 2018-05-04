let
  accessKeyId = "example";
  region = "ap-southeast-1";
  ec2 = { resources, ... }:
    {
      deployment.targetEnv = "ec2";
      deployment.ec2.region = region;
      deployment.ec2.instanceType = "t2.micro";
      deployment.ec2.ebsInitialRootDiskSize = 25;
      deployment.ec2.accessKeyId = accessKeyId;
      deployment.ec2.keyPair = resources.ec2KeyPairs.my-key-pair;
      deployment.ec2.securityGroups = [ "test" ];
    };
in
  {
    testInstance = ec2;
    resources.ec2KeyPairs.my-key-pair = {
      inherit region accessKeyId;
    };
  }

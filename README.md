# Genomics Workflows on AWS

**This is a stripped down clone of https://github.com/umccr/aws-genomics-workflows made on 2020-11-10 by UMCCR**

This repository is the source code for [Genomics Workflows on AWS](https://docs.opendata.aws/genomics-workflows).  It contains markdown documents that are used to build the site as well as source code (CloudFormation templates, scripts, etc) that can be used to deploy AWS infrastructure for running genomics workflows.

If you want to get the latest version of these solutions up and running quickly, it is recommended that you deploy stacks using the launch buttons available via the [hosted guide](https://docs.opendata.aws/genomics-workflows).

If you want to customize these solutions, you can create your own distribution using the instructions below.

## Creating your own distribution

Clone the repo

```bash
git clone https://github.com/aws-samples/aws-genomics-workflows.git
```

Create an S3 bucket in your AWS account to use for the distribution deployment

```bash
aws s3 mb <dist-bucketname>
```

Create and deploy a distribution from source

```bash
cd aws-genomics-workflows
bash _scripts/deploy.sh --asset-bucket s3://<dist-bucketname> test
```

This will create a `dist` folder in the root of the project with subfolders `dist/artifacts` and `dist/templates` that will be uploaded to the S3 bucket you created above.

You can now use your deployed distribution to launch stacks using the AWS CLI. For example, to launch the GWFCore stack:

```bash
TEMPLATE_ROOT_URL=https://<dist-bucketname>.s3-<region>.amazonaws.com/test/templates

aws cloudformation create-stack \
    --region <region> \
    --stack-name <stackname> \
    --template-url $TEMPLATE_ROOT_URL/gwfcore-root.template.yaml \
    --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
    --parameters \
        ParameterKey=VpcId,ParameterValue=<vpc-id> \
        ParameterKey=SubnetIds,ParameterValue=\"<subnet-id-1>,<subnet-id-2>,...\" \
        ParameterKey=ArtifactBucketName,ParameterValue=<dist-bucketname> \
        ParameterKey=TemplateRootUrl,ParameterValue=$TEMPLATE_ROOT_URL

```

## Building the documentation

The documentation is built using mkdocs.

Install dependencies:

```bash
$ conda env create --file environment.yaml
```

This will create a `conda` environment called `mkdocs`

Build the docs:

```bash
$ conda activate mkdocs
$ mkdocs build
```

## License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.

#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "rypock-node" {
  name = "terraform-eks-rypock-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "rypock-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.rypock-node.name
}

resource "aws_iam_role_policy_attachment" "rypock-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.rypock-node.name
}

resource "aws_iam_role_policy_attachment" "rypock-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.rypock-node.name
}

resource "aws_eks_node_group" "rypock" {
  cluster_name    = aws_eks_cluster.rypock.name
  node_group_name = "rypock"
  node_role_arn   = aws_iam_role.rypock-node.arn
  subnet_ids      = aws_subnet.rypock[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.rypock-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.rypock-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.rypock-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

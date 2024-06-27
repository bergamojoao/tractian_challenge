class TreeNode<T> {
  final T content;
  final String id;
  final String? parentId;
  final List<TreeNode<dynamic>> children = [];
  bool isExpanded = false;

  TreeNode({
    required this.content,
    required this.id,
    this.parentId,
    this.isExpanded = false,
  });

  static TreeNode? buildTree({required List<TreeNode> data, String? parentId}) {
    TreeNode? parentNode;
    for (var node in data) {
      if (node.id == parentId) {
        parentNode = node;
        break;
      }
    }

    if (parentNode == null) {
      return null;
    }

    for (var node in data) {
      if (node.parentId == parentNode.id) {
        TreeNode? childNode = buildTree(data: data, parentId: node.id);
        if (childNode != null) {
          parentNode.children.add(childNode as TreeNode<Object>);
        }
      }
    }

    return parentNode;
  }

  static TreeNode? filter(TreeNode node, bool Function(TreeNode) condition) {
    List<TreeNode> filteredChildren = [];

    for (var child in node.children) {
      TreeNode? filteredChild = filter(child, condition);
      if (filteredChild != null) {
        filteredChildren.add(filteredChild);
      } else if (condition(node)) {
        filteredChildren.add(child);
      }
    }

    if (condition(node) || filteredChildren.isNotEmpty) {
      var filteredNode = TreeNode(id: node.id, content: node.content);
      for (var child in filteredChildren) {
        filteredNode.children.add(child);
      }
      return filteredNode;
    }

    return null;
  }
}

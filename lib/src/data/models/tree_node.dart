class TreeNode<T> {
  final T content;
  final String id;
  final String? parentId;
  final List<TreeNode<Object>> children = [];

  TreeNode({
    required this.content,
    required this.id,
    this.parentId,
  });
}

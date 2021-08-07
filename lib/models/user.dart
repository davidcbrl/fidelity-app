class User {
  final int id;
  final String email;
  final String name;
  final String fantasyName;

  User(
    this.email,
    this.id,
    this.name,
    this.fantasyName,
  );

  @override
  String toString() {
    return 'User{ id: $id, name: $name, fantasyName: $fantasyName}';
  }
}

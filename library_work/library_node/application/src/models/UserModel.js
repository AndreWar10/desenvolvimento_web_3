class UserModel {
  constructor(name, email, password, id = null) {
    this.id = id; // Agora id é opcional
    this.name = name;
    this.email = email;
    this.password = password;
  }

  toJson() {
    return {
      id: this.id,
      name: this.name,
      email: this.email,
      password: this.password,
    };
  }
}

module.exports = UserModel;

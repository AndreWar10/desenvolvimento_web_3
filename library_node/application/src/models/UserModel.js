class UserModel {
    constructor(name, email) {
      this.name = name;
      this.email = email;
    }
  
    toJson() {
      return {
        name: this.name,
        email: this.email,
      };
    }
  }
    
    module.exports = UserModel;
    
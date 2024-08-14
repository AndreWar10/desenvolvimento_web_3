class AuthorModel {
    constructor(name, nationality) {
      this.name = name;
      this.nationality = nationality;
    }
  
    toJson() {
      return {
        name: this.name,
        nationality: this.nationality
      };
    }
  }
    
    module.exports = AuthorModel;
    
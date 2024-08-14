class LendingModel {
    constructor(idUser, nameUser, bookName, dtLocation, status) {
      this.idUser = idUser;
      this.nameUser = nameUser;
      this.bookName = bookName;
      this.dtLocation = dtLocation;
      this.status = status;
    }
  
    toJson() {
      return {
        idUser: this.idUser,
        nameUser: this.nameUser,
        bookName: this.bookName,
        dtLocation: this.dtLocation,
        name: this.name,
        status: this.status
      };
    }
  }
    
    module.exports = LendingModel;
    
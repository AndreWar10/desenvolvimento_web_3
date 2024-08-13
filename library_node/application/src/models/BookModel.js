class BookModel {
  constructor(author, isbn, title, year) {
    this.author = author;
    this.isbn = parseInt(isbn, 10);
    this.title = title;
    this.year = parseInt(year, 10);
  }

  // Método para converter a instância em um objeto simples
  toPlainObject() {
    return {
      author: this.author,
      isbn: this.isbn,
      title: this.title,
      year: this.year
    };
  }
}
  
  module.exports = BookModel;
  
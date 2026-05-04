package model;

public class EBook extends Book {
    private String fileSize;
    private String downloadLink;

    public EBook() {
        super();
        setType("EBOOK");
    }

    public EBook(String id, String title, String author, double price, String category, int stock, String fileSize, String downloadLink) {
        super(id, title, author, price, category, stock, "EBOOK");
        this.fileSize = fileSize;
        this.downloadLink = downloadLink;
    }

    public String getFileSize() { return fileSize; }
    public void setFileSize(String fileSize) { this.fileSize = fileSize; }

    public String getDownloadLink() { return downloadLink; }
    public void setDownloadLink(String downloadLink) { this.downloadLink = downloadLink; }

    @Override
    public String toString() {
        return super.toString() + "|" + fileSize + "|" + downloadLink;
    }
}

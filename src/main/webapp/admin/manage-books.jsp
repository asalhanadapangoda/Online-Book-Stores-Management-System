<%@ page import="model.*, service.BookService, java.util.List" %>
<%@ include file="../header.jsp" %>
<% 
    String dataPath = service.FileService.DATA_PATH;
    BookService bookService = new BookService(dataPath);
    List<Book> books = bookService.getAllBooks();
%>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Manage Books</h2>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">+ Add New Book</button>
</div>

<div class="card shadow-sm">
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Type</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Book b : books) { %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getTitle() %></td>
                    <td><%= b.getAuthor() %></td>
                    <td>$<%= b.getPrice() %></td>
                    <td><span class="badge bg-secondary"><%= b.getType() %></span></td>
                    <td><%= b.getStock() %></td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editBook('<%= b.getId() %>', '<%= b.getTitle().replace("'", "\\'") %>', '<%= b.getAuthor().replace("'", "\\'") %>', <%= b.getPrice() %>, '<%= b.getCategory().replace("'", "\\'") %>', <%= b.getStock() %>, '<%= b.getType() %>', '<%= (b instanceof EBook) ? ((EBook)b).getFileSize() : "" %>', '<%= (b instanceof EBook) ? ((EBook)b).getDownloadLink() : "" %>')">Edit</button>
                        <a href="../admin?action=deleteBook&id=<%= b.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Book Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="../admin" method="POST">
                <input type="hidden" name="action" value="addBook">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Title</label>
                        <input type="text" name="title" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Author</label>
                        <input type="text" name="author" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" step="0.01" name="price" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Stock</label>
                            <input type="number" name="stock" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <input type="text" name="category" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Type</label>
                        <select name="type" class="form-select" id="bookType" onchange="toggleFields()">
                            <option value="PRINTED">Printed Book</option>
                            <option value="EBOOK">E-Book</option>
                        </select>
                    </div>
                    
                    <div id="printedFields">
                        <!-- Physical book specific options removed -->
                    </div>
                    
                    <div id="ebookFields" style="display:none;">
                        <div class="mb-3">
                            <label class="form-label">File Size</label>
                            <input type="text" name="fileSize" class="form-control" value="2MB">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Download Link</label>
                            <input type="text" name="downloadLink" class="form-control" value="http://example.com/download">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Book</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="editBookModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="../admin" method="POST">
                <input type="hidden" name="action" value="updateBook">
                <input type="hidden" name="id" id="editId">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Title</label>
                        <input type="text" name="title" id="editTitle" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Author</label>
                        <input type="text" name="author" id="editAuthor" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" step="0.01" name="price" id="editPrice" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Stock</label>
                            <input type="number" name="stock" id="editStock" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <input type="text" name="category" id="editCategory" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Type</label>
                        <input type="text" name="type" id="editType" class="form-control" readonly>
                    </div>
                    
                    <div id="editPrintedFields">
                        <!-- Physical book specific options removed -->
                    </div>
                    
                    <div id="editEbookFields" style="display:none;">
                        <div class="mb-3">
                            <label class="form-label">File Size</label>
                            <input type="text" name="fileSize" id="editFileSize" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Download Link</label>
                            <input type="text" name="downloadLink" id="editDownloadLink" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update Book</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function toggleFields() {
    var type = document.getElementById('bookType').value;
    document.getElementById('printedFields').style.display = (type === 'PRINTED' ? 'block' : 'none');
    document.getElementById('ebookFields').style.display = (type === 'EBOOK' ? 'block' : 'none');
}

function editBook(id, title, author, price, category, stock, type, fileSize, downloadLink) {
    document.getElementById('editId').value = id;
    document.getElementById('editTitle').value = title;
    document.getElementById('editAuthor').value = author;
    document.getElementById('editPrice').value = price;
    document.getElementById('editCategory').value = category;
    document.getElementById('editStock').value = stock;
    document.getElementById('editType').value = type;
    
    if (type === 'EBOOK') {
        document.getElementById('editEbookFields').style.display = 'block';
        document.getElementById('editPrintedFields').style.display = 'none';
        document.getElementById('editFileSize').value = fileSize;
        document.getElementById('editDownloadLink').value = downloadLink;
    } else {
        document.getElementById('editEbookFields').style.display = 'none';
        document.getElementById('editPrintedFields').style.display = 'block';
    }
    
    var editModal = new bootstrap.Modal(document.getElementById('editBookModal'));
    editModal.show();
}
</script>

<%@ include file="../footer.jsp" %>

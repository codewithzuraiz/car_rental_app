<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?php echo isset($pageTitle) ? $pageTitle . ' - ' : ''; ?>AutoElite Platform Admin</title>
  <link rel="stylesheet" href="assets/style.css">
  <!-- Firebase App & Firestore Web SDK for live browser reactivity -->
  <script src="https://www.gstatic.com/firebasejs/9.22.1/firebase-app-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.22.1/firebase-firestore-compat.js"></script>
</head>
<body>
  <?php include 'includes/sidebar.php'; ?>
  <div class="admin-main">
    <header class="admin-header">
      <div class="page-title"><?php echo isset($pageTitle) ? htmlspecialchars($pageTitle) : 'Admin Console'; ?></div>
      <div class="header-user">
        <span class="user-badge">Firebase Project: <?php echo FIREBASE_PROJECT_ID; ?></span>
        <div style="font-weight: 700; font-size: 14px;">Master Admin (Alex Vance)</div>
      </div>
    </header>
    <div class="admin-content">

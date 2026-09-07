<?php
$currentFile = basename($_SERVER['PHP_SELF']);
?>
<aside class="admin-sidebar">
  <div class="brand">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#7cc2fd" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
      <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.5 2.8C2.1 10.8 2 11 2 11.3V16c0 .6.4 1 1 1h2"></path>
      <circle cx="7" cy="17" r="2"></circle>
      <circle cx="17" cy="17" r="2"></circle>
    </svg>
    <div class="brand-title">AutoElite<span style="color:#7cc2fd;">Admin</span></div>
  </div>
  <ul class="sidebar-nav">
    <li>
      <a href="index.php" class="<?php echo $currentFile === 'index.php' ? 'active' : ''; ?>">
        <span>📊</span> Overview & Analytics
      </a>
    </li>
    <li>
      <a href="moderation.php" class="<?php echo $currentFile === 'moderation.php' ? 'active' : ''; ?>">
        <span>🛡️</span> Listings Moderation
      </a>
    </li>
    <li>
      <a href="users.php" class="<?php echo $currentFile === 'users.php' ? 'active' : ''; ?>">
        <span>👥</span> Users & KYC Verification
      </a>
    </li>
    <li>
      <a href="escrow.php" class="<?php echo $currentFile === 'escrow.php' ? 'active' : ''; ?>">
        <span>🔒</span> Escrow & Operations
      </a>
    </li>
  </ul>
  <div class="sidebar-footer">
    <div>AutoElite v2.4 Enterprise</div>
    <div style="margin-top: 4px; opacity: 0.8;">Connected to Firestore</div>
  </div>
</aside>

<?php
require_once 'config/firebase_config.php';
$pageTitle = 'Users & KYC Verification Directory';
include 'includes/header.php';
?>

<div class="metrics-grid">
  <div class="metric-card">
    <div class="metric-header">
      <span>TOTAL REGISTERED USERS</span>
      <span>👥</span>
    </div>
    <div class="metric-value">1,482</div>
    <div class="metric-trend up">+142 this week</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>TIER 2 VERIFIED DRIVERS</span>
      <span>🪪</span>
    </div>
    <div class="metric-value">1,120</div>
    <div class="metric-trend up">Cleared for Luxury Test Drives</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>TIER 3 VIP ESCROW BUYERS</span>
      <span>💎</span>
    </div>
    <div class="metric-value">340</div>
    <div class="metric-trend up">Accredited Net-Worth</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>PENDING KYC DOCUMENTS</span>
      <span>📑</span>
    </div>
    <div class="metric-value">6 Pending</div>
    <div class="metric-trend warn">Requires ID validation</div>
  </div>
</div>

<div class="data-card">
  <div class="data-card-header">
    <h3>Identity & KYC Verification Queue</h3>
    <input type="text" placeholder="Search user by name, email, or VIN..." style="padding: 8px 14px; border-radius: 8px; border: 1px solid var(--outline-variant); font-size: 13px; width: 280px;">
  </div>
  <table class="data-table">
    <thead>
      <tr>
        <th>User Profile</th>
        <th>Account Role</th>
        <th>Submitted Document</th>
        <th>Current Status</th>
        <th>Test Drive Clearance</th>
        <th>KYC Action</th>
      </tr>
    </thead>
    <tbody>
      <tr id="user-row-1">
        <td>
          <strong>Alex Mitchell</strong><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">alex.mitchell@luxurymail.com • +1 (310) 982-1204</span>
        </td>
        <td><span class="badge badge-info">Buyer</span></td>
        <td>
          <strong>California Real ID (Driver's License)</strong><br>
          <span style="font-size: 11px; color: var(--secondary);">Valid through 2029 • Exp: Clean Record</span>
        </td>
        <td><span class="badge badge-success">Tier 2 Verified</span></td>
        <td><span class="badge badge-success">Approved ($200k Cap)</span></td>
        <td>
          <button class="btn btn-primary btn-sm" onclick="upgradeToVip('user-row-1')">Grant Tier 3 VIP</button>
        </td>
      </tr>

      <tr id="user-row-2">
        <td>
          <strong>Marcus Vance (AutoElite Showroom)</strong><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">marcus@autoelite.com • +1 (310) 555-0199</span>
        </td>
        <td><span class="badge badge-info">Certified Dealer</span></td>
        <td>
          <strong>CA State DMV Dealer License #902812</strong><br>
          <span style="font-size: 11px; color: var(--secondary);">Surety Bond $100,000 Verified</span>
        </td>
        <td><span class="badge badge-success">Tier 3 VIP Verified</span></td>
        <td><span class="badge badge-success">Unlimited Escrow</span></td>
        <td>
          <span style="font-size: 12px; color: var(--success); font-weight: 700;">Active Partner</span>
        </td>
      </tr>

      <tr id="user-row-3">
        <td>
          <strong>Elena Rostova</strong><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">elena.r@investorvault.io • +1 (415) 882-9011</span>
        </td>
        <td><span class="badge badge-info">Buyer</span></td>
        <td>
          <strong>International Passport & Proof of Funds</strong><br>
          <span style="font-size: 11px; color: var(--warning);">Pending Review by Compliance</span>
        </td>
        <td><span class="badge badge-warning">Verification Pending</span></td>
        <td><span class="badge badge-warning">Pending Approval</span></td>
        <td>
          <div style="display: flex; gap: 6px;">
            <button class="btn btn-primary btn-sm" onclick="verifyUser('user-row-3')">Approve KYC</button>
            <button class="btn btn-outline btn-sm" onclick="rejectUser('user-row-3')">Reject</button>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<script>
function upgradeToVip(rowId) {
  const row = document.getElementById(rowId);
  row.cells[3].innerHTML = '<span class="badge badge-success">Tier 3 VIP Verified</span>';
  row.cells[4].innerHTML = '<span class="badge badge-success">Unlimited Escrow Cap</span>';
  row.cells[5].innerHTML = '<span style="font-size: 12px; color: var(--success); font-weight: 700;">Tier 3 VIP Active ✓</span>';
}

function verifyUser(rowId) {
  const row = document.getElementById(rowId);
  row.cells[3].innerHTML = '<span class="badge badge-success">Tier 2 Verified</span>';
  row.cells[4].innerHTML = '<span class="badge badge-success">Approved ($200k Cap)</span>';
  row.cells[5].innerHTML = '<span style="font-size: 12px; color: var(--success); font-weight: 700;">Approved ✓</span>';
}

function rejectUser(rowId) {
  const row = document.getElementById(rowId);
  row.cells[3].innerHTML = '<span class="badge badge-warning">Rejected</span>';
  row.cells[5].innerHTML = '<span style="font-size: 12px; color: var(--error); font-weight: 700;">Declined ✕</span>';
}
</script>

<?php include 'includes/footer.php'; ?>

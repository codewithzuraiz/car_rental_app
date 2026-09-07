<?php
require_once 'config/firebase_config.php';
$pageTitle = 'Listings Moderation Queue';
include 'includes/header.php';
?>

<div class="data-card">
  <div class="data-card-header">
    <div>
      <h3>Pending Vehicle Inspection Reviews (3 Submissions)</h3>
      <p style="font-size: 13px; color: var(--on-surface-variant); margin-top: 4px;">
        Every vehicle published on AutoElite must undergo independent 150-point mechanical certification before public showroom listing.
      </p>
    </div>
    <button class="btn btn-secondary btn-sm" onclick="alert('Auto-approving high-trust dealers')">Batch Validate</button>
  </div>
  <table class="data-table">
    <thead>
      <tr>
        <th>Vehicle Submission</th>
        <th>VIN & Specs</th>
        <th>150-Pt Report</th>
        <th>Asking Price</th>
        <th>Seller / Dealership</th>
        <th>Risk Assessment</th>
        <th>Moderation Action</th>
      </tr>
    </thead>
    <tbody>
      <tr id="row-mod-1">
        <td>
          <strong>2024 BMW M3 CS Competition</strong><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">Sedan • Frozen Solid White</span>
        </td>
        <td>
          <code>WBA33AY08PFP99182</code><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">543 HP • 1,200 mi</span>
        </td>
        <td>
          <span class="badge badge-success">99/100 Score</span><br>
          <a href="#" style="font-size: 11px; color: var(--secondary);" onclick="alert('Viewing 150-point inspection PDF proof'); return false;">View PDF Proof</a>
        </td>
        <td style="font-weight: 700; color: var(--primary);">$118,000</td>
        <td>
          <strong>AutoElite Dealership</strong><br>
          <span style="font-size: 11px; color: var(--on-surface-variant);">Tier 3 VIP Dealer</span>
        </td>
        <td><span class="badge badge-success">Low Risk (Verified)</span></td>
        <td>
          <div style="display: flex; gap: 6px;">
            <button class="btn btn-primary btn-sm" onclick="approveListing('row-mod-1')">Approve</button>
            <button class="btn btn-outline btn-sm" onclick="rejectListing('row-mod-1')">Reject</button>
          </div>
        </td>
      </tr>

      <tr id="row-mod-2">
        <td>
          <strong>2022 Porsche 911 GT3 Touring</strong><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">Coupe • Shark Blue</span>
        </td>
        <td>
          <code>WP0AC2A94NS210982</code><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">502 HP • 3,400 mi</span>
        </td>
        <td>
          <span class="badge badge-warning">94/100 Flagged</span><br>
          <a href="#" style="font-size: 11px; color: var(--secondary);" onclick="alert('Minor brake wear flagged on point 42'); return false;">Point 42 Brake Wear</a>
        </td>
        <td style="font-weight: 700; color: var(--primary);">$215,000</td>
        <td>
          <strong>Private Collector (Julian K.)</strong><br>
          <span style="font-size: 11px; color: var(--on-surface-variant);">Tier 2 Verified</span>
        </td>
        <td><span class="badge badge-warning">Inspection Flag</span></td>
        <td>
          <div style="display: flex; gap: 6px;">
            <button class="btn btn-primary btn-sm" onclick="approveListing('row-mod-2')">Approve</button>
            <button class="btn btn-outline btn-sm" onclick="requestReinspection('row-mod-2')">Re-Check</button>
          </div>
        </td>
      </tr>

      <tr id="row-mod-3">
        <td>
          <strong>2023 Audi RS6 Avant</strong><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">Wagon • Daytona Grey Matte</span>
        </td>
        <td>
          <code>WAUZZZF28PN012398</code><br>
          <span style="font-size: 12px; color: var(--on-surface-variant);">591 HP • 9,800 mi</span>
        </td>
        <td>
          <span class="badge badge-success">98/100 Score</span><br>
          <a href="#" style="font-size: 11px; color: var(--secondary);" onclick="alert('Inspection certified by Audi Beverly Hills'); return false;">Full Dealer History</a>
        </td>
        <td style="font-weight: 700; color: var(--primary);">$129,500</td>
        <td>
          <strong>Beverly Hills Motors</strong><br>
          <span style="font-size: 11px; color: var(--on-surface-variant);">Premier Partner</span>
        </td>
        <td><span class="badge badge-success">Low Risk (Verified)</span></td>
        <td>
          <div style="display: flex; gap: 6px;">
            <button class="btn btn-primary btn-sm" onclick="approveListing('row-mod-3')">Approve</button>
            <button class="btn btn-outline btn-sm" onclick="rejectListing('row-mod-3')">Reject</button>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<script>
function approveListing(rowId) {
  const row = document.getElementById(rowId);
  row.style.opacity = '0.5';
  row.cells[5].innerHTML = '<span class="badge badge-success">Published to Live Showroom</span>';
  row.cells[6].innerHTML = '<span style="font-size: 12px; color: var(--success); font-weight:700;">Approved ✓</span>';
}

function rejectListing(rowId) {
  const row = document.getElementById(rowId);
  row.style.opacity = '0.4';
  row.cells[5].innerHTML = '<span class="badge badge-warning">Rejected</span>';
  row.cells[6].innerHTML = '<span style="font-size: 12px; color: var(--error); font-weight:700;">Rejected ✕</span>';
}

function requestReinspection(rowId) {
  alert('Re-inspection request dispatched to seller with instructions.');
}
</script>

<?php include 'includes/footer.php'; ?>

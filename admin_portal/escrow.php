<?php
require_once 'config/firebase_config.php';
$pageTitle = 'Escrow & Financial Operations';
include 'includes/header.php';
?>

<div class="metrics-grid">
  <div class="metric-card">
    <div class="metric-header">
      <span>TOTAL HELD IN ESCROW</span>
      <span>🔒</span>
    </div>
    <div class="metric-value">$684,200</div>
    <div class="metric-trend up">Guaranteed FDIC Insured Vault</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>ACTIVE TRANSACTIONS</span>
      <span>🤝</span>
    </div>
    <div class="metric-value">5 Vehicles</div>
    <div class="metric-trend up">In 48-Hour Inspection Window</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>SUCCESSFUL PAYOUTS YTD</span>
      <span>💰</span>
    </div>
    <div class="metric-value">$3,410,000</div>
    <div class="metric-trend up">Zero Chargebacks</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>DISPUTES IN ESCROW</span>
      <span>⚖️</span>
    </div>
    <div class="metric-value">0 Cases</div>
    <div class="metric-trend up">100% Resolved amicably</div>
  </div>
</div>

<div class="data-card">
  <div class="data-card-header">
    <div>
      <h3>Live Escrow Agreements & Fund Disbursal</h3>
      <p style="font-size: 13px; color: var(--on-surface-variant); margin-top: 4px;">
        AutoElite Escrow holds certified buyer wires until the vehicle is delivered and passed physical 48-hour buyer inspection.
      </p>
    </div>
    <button class="btn btn-primary btn-sm" onclick="alert('Exporting settlement statement')">Export Settlement Statement</button>
  </div>
  <table class="data-table">
    <thead>
      <tr>
        <th>Escrow ID</th>
        <th>Vehicle</th>
        <th>Buyer & Seller</th>
        <th>Locked Amount</th>
        <th>Current Milestone</th>
        <th>Inspection Window</th>
        <th>Disbursement Action</th>
      </tr>
    </thead>
    <tbody>
      <tr id="escrow-row-1">
        <td><code>ESC-99281-BMW</code></td>
        <td>
          <strong>2024 BMW M4 Competition</strong><br>
          <span style="font-size: 11px; color: var(--on-surface-variant);">VIN: WBA33AY08PFP99182</span>
        </td>
        <td>
          Buyer: <strong>Alex Mitchell</strong><br>
          Seller: AutoElite Certified Dealership
        </td>
        <td style="font-weight: 700; color: var(--primary); font-size: 16px;">$82,900</td>
        <td><span class="badge badge-success">Delivered (Pending Sign-off)</span></td>
        <td><strong>28h Remaining</strong></td>
        <td>
          <button class="btn btn-secondary btn-sm" onclick="releaseEscrow('escrow-row-1', '82,900')">Release to Seller</button>
        </td>
      </tr>

      <tr id="escrow-row-2">
        <td><code>ESC-88172-MB</code></td>
        <td>
          <strong>2024 Mercedes-AMG GT 63 S</strong><br>
          <span style="font-size: 11px; color: var(--on-surface-variant);">VIN: WDD2906891A992812</span>
        </td>
        <td>
          Buyer: <strong>David Sterling</strong><br>
          Seller: Mercedes-Benz of South Coast
        </td>
        <td style="font-weight: 700; color: var(--primary); font-size: 16px;">$162,000</td>
        <td><span class="badge badge-info">In Transit (Covered Carrier)</span></td>
        <td>Scheduled for Tomorrow</td>
        <td>
          <button class="btn btn-outline btn-sm" onclick="alert('Carrier tracking: Live on interstate I-5')">Track Carrier</button>
        </td>
      </tr>

      <tr id="escrow-row-3">
        <td><code>ESC-77162-POR</code></td>
        <td>
          <strong>2023 Porsche 911 Carrera S</strong><br>
          <span style="font-size: 11px; color: var(--on-surface-variant);">VIN: WP0AB2A99PS182736</span>
        </td>
        <td>
          Buyer: <strong>Sophia Chen</strong><br>
          Seller: Beverly Hills Motors
        </td>
        <td style="font-weight: 700; color: var(--primary); font-size: 16px;">$128,500</td>
        <td><span class="badge badge-success">Completed & Disbursed</span></td>
        <td>Inspection Approved ✓</td>
        <td>
          <span style="font-size: 12px; color: var(--success); font-weight: 700;">Wire Settled ✓</span>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<script>
function releaseEscrow(rowId, amount) {
  if (confirm('Confirm disbursement of $' + amount + ' to seller account via Fedwire?')) {
    const row = document.getElementById(rowId);
    row.cells[4].innerHTML = '<span class="badge badge-success">Completed & Disbursed</span>';
    row.cells[5].innerHTML = 'Sign-off Verified ✓';
    row.cells[6].innerHTML = '<span style="font-size: 12px; color: var(--success); font-weight: 700;">Disbursed via Fedwire ✓</span>';
  }
}
</script>

<?php include 'includes/footer.php'; ?>

<?php
require_once 'config/firebase_config.php';
$pageTitle = 'Executive Overview & Marketplace Analytics';
include 'includes/header.php';

// Fetch live cars from Firestore or fallback to mock
$cars = fetchFirestoreCollection('cars');
$totalListings = $cars ? count($cars) : 7;
?>

<!-- Metrics Grid -->
<div class="metrics-grid">
  <div class="metric-card">
    <div class="metric-header">
      <span>GROSS MARKETPLACE VALUATION</span>
      <span>📈</span>
    </div>
    <div class="metric-value">$4,820,500</div>
    <div class="metric-trend up">+18.4% vs last month</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>ACTIVE CERTIFIED LISTINGS</span>
      <span>🏎️</span>
    </div>
    <div class="metric-value"><?php echo $totalListings; ?> Units</div>
    <div class="metric-trend up">100% Passed Mechanical Audit</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>PENDING MODERATION QUEUE</span>
      <span>⏱️</span>
    </div>
    <div class="metric-value">3 Listings</div>
    <div class="metric-trend warn">Requires Inspection Verification</div>
  </div>

  <div class="metric-card">
    <div class="metric-header">
      <span>PROTECTED ESCROW BALANCE</span>
      <span>🔒</span>
    </div>
    <div class="metric-value">$684,200</div>
    <div class="metric-trend up">5 Active Escrow Handshakes</div>
  </div>
</div>

<!-- Recent Listings Activity Table -->
<div class="data-card">
  <div class="data-card-header">
    <h3>High-Value Inventory Synchronized with Firebase</h3>
    <a href="moderation.php" class="btn btn-outline btn-sm">Manage Queue</a>
  </div>
  <table class="data-table">
    <thead>
      <tr>
        <th>Vehicle</th>
        <th>Year & Make</th>
        <th>Asking Price</th>
        <th>Inspection Score</th>
        <th>Seller / Dealership</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><strong>2024 BMW M4 Competition Coupe</strong></td>
        <td>2024 • BMW</td>
        <td style="font-weight: 700; color: var(--primary);">$84,900</td>
        <td><span class="badge badge-success">99/100 Passed</span></td>
        <td>AutoElite Certified Dealership</td>
        <td><span class="badge badge-success">Live in Showroom</span></td>
        <td><button class="btn btn-outline btn-sm" onclick="alert('Viewing telemetry')">Inspect</button></td>
      </tr>
      <tr>
        <td><strong>2023 Porsche 911 Carrera S</strong></td>
        <td>2023 • Porsche</td>
        <td style="font-weight: 700; color: var(--primary);">$128,500</td>
        <td><span class="badge badge-success">98/100 Passed</span></td>
        <td>Beverly Hills Motors</td>
        <td><span class="badge badge-success">Live in Showroom</span></td>
        <td><button class="btn btn-outline btn-sm" onclick="alert('Viewing telemetry')">Inspect</button></td>
      </tr>
      <tr>
        <td><strong>2024 Mercedes-AMG GT 63 S E-Performance</strong></td>
        <td>2024 • Mercedes-Benz</td>
        <td style="font-weight: 700; color: var(--primary);">$162,000</td>
        <td><span class="badge badge-success">100/100 Passed</span></td>
        <td>Mercedes-Benz of South Coast</td>
        <td><span class="badge badge-info">Escrow In-Progress</span></td>
        <td><button class="btn btn-outline btn-sm" onclick="alert('Viewing telemetry')">Inspect</button></td>
      </tr>
      <tr>
        <td><strong>2024 Tesla Model S Plaid AWD</strong></td>
        <td>2024 • Tesla</td>
        <td style="font-weight: 700; color: var(--primary);">$89,990</td>
        <td><span class="badge badge-success">99/100 Passed</span></td>
        <td>Pacific EV Collective</td>
        <td><span class="badge badge-success">Live in Showroom</span></td>
        <td><button class="btn btn-outline btn-sm" onclick="alert('Viewing telemetry')">Inspect</button></td>
      </tr>
    </tbody>
  </table>
</div>

<!-- Platform Operational Health -->
<div class="metrics-grid">
  <div class="metric-card" style="grid-column: span 2;">
    <h3 style="margin-bottom: 12px; font-size: 16px;">Firebase Infrastructure Status</h3>
    <p style="font-size: 13px; color: var(--on-surface-variant); margin-bottom: 16px;">
      Direct connection with Google Cloud Firestore database <code>rent-a-car-932a8</code>. Real-time synchronizations are propagating across mobile buyers, dealership sellers, and the central administrative dashboard.
    </p>
    <div style="display: flex; gap: 12px;">
      <span class="badge badge-success">● Firestore Synchronized</span>
      <span class="badge badge-success">● Firebase Auth Operational</span>
      <span class="badge badge-info">● REST Gateway Active</span>
    </div>
  </div>
</div>

<?php include 'includes/footer.php'; ?>

    </div><!-- /.admin-content -->
  </div><!-- /.admin-main -->

  <script>
    // Initialize Firebase in browser for client interactivity
    const firebaseConfig = {
      apiKey: "<?php echo FIREBASE_API_KEY; ?>",
      projectId: "<?php echo FIREBASE_PROJECT_ID; ?>",
    };
    try {
      firebase.initializeApp(firebaseConfig);
      console.log("Firebase initialized in AutoElite Admin Portal.");
    } catch(e) {
      console.log("Firebase notice:", e);
    }
  </script>
</body>
</html>

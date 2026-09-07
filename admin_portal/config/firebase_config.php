<?php
// Firebase Configuration for AutoElite Admin Portal
define('FIREBASE_PROJECT_ID', 'rent-a-car-932a8');
define('FIREBASE_API_KEY', 'AIzaSyDYklEUCeaNqQY9xyRqJwPdJGQj1wNi_yc');
define('FIRESTORE_REST_BASE', 'https://firestore.googleapis.com/v1/projects/' . FIREBASE_PROJECT_ID . '/databases/(default)/documents/');

function fetchFirestoreCollection($collection) {
    $url = FIRESTORE_REST_BASE . $collection;
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 4);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode === 200 && $response) {
        $data = json_decode($response, true);
        if (isset($data['documents'])) {
            return $data['documents'];
        }
    }
    return null;
}
?>

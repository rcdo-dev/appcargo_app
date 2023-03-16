package br.com.appcargo;

import com.grouplinknetwork.GroupLink;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    @Override
    public void onCreate() {
        GroupLink.register(
                getApplicationContext(),
                "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NTU3NTIwMzgsImlkIjoxMzQsIm5hbWUiOiJBcHBDYXJnbyIsIm9zIjoiYW5kcm9pZCIsImxlZ2FjeSI6ZmFsc2V9.S5UWNgO2lmsi7L0uyGnqUZpYk0DXS5gTRK2prEj3YSs",
                false //true if you want to test if the implementation is working.
        );
        super.onCreate();
    }
}

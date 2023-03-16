package br.com.appcargo;

import android.os.Bundle;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        // https://medium.com/@diegoveloper/flutter-splash-screen-9f4e05542548
        ViewTreeObserver vto = getFlutterView().getViewTreeObserver();
        vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                getFlutterView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
                getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
            }
        });
    }
}
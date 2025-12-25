package com.example.kh_logistics_internal_demo;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.kh_logistics_internal_demo.km_mode.Send;
import com.example.kh_logistics_internal_demo.km_mode.UseCase;

public class CustomViewActivity extends AppCompatActivity {

    static byte[] imageData;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.custom_view);

//        Intent intent = this.getIntent();
//        byte[] image = intent.getByteArrayExtra("image");

        Bitmap bmp = BitmapFactory.decodeByteArray(imageData, 0, imageData.length);

        ImageView view = findViewById(R.id.custom_image);

        view.setImageBitmap(bmp);


        Button btn = findViewById(R.id.btn_pint);

        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                FrameLayout fram = findViewById(R.id.framlayout);
                TextView text = findViewById(R.id.text);

//                Send.writeData(UseCase.tspl_case2(CustomViewActivity.this, loadBitmapFromView(fram)), CustomViewActivity.this);
                Send.writeData(UseCase.tspl_case2(CustomViewActivity.this, loadBitmapFromView(fram)), CustomViewActivity.this);



            }
        });



    }

    public Bitmap loadBitmapFromViewOrBitmap(View v, Bitmap bitmap) {
        // If bitmap already exists, return it directly
        if (bitmap != null) {
            return bitmap;
        }

        // Otherwise, create bitmap from View (your original logic)
        DisplayMetrics dm = getResources().getDisplayMetrics();
        v.measure(
                View.MeasureSpec.makeMeasureSpec(dm.widthPixels, View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(dm.heightPixels, View.MeasureSpec.EXACTLY)
        );
        v.layout(0, 0, v.getMeasuredWidth(), v.getMeasuredHeight());

        Bitmap returnedBitmap = Bitmap.createBitmap(
                v.getMeasuredWidth(),
                v.getMeasuredHeight(),
                Bitmap.Config.ARGB_8888
        );

        Canvas c = new Canvas(returnedBitmap);
        v.draw(c);

        return returnedBitmap;
    }

    public Bitmap loadBitmapFromView(View v) {
        DisplayMetrics dm = getResources().getDisplayMetrics();
        v.measure(View.MeasureSpec.makeMeasureSpec(dm.widthPixels,
                        View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(dm.heightPixels,
                        View.MeasureSpec.EXACTLY));
        v.layout(0, 0, v.getMeasuredWidth(), v.getMeasuredHeight());
        Bitmap returnedBitmap =
                Bitmap.createBitmap(v.getMeasuredWidth(),
                        v.getMeasuredHeight(), Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(returnedBitmap);
        v.draw(c);

        return returnedBitmap;
    }
}

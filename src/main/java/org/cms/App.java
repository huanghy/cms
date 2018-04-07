package org.cms;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import com.cqunis.cms.entity.ExRecord;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Timer timer = new Timer();
    	timer.schedule(new TimerTask() {
            @Override
            public void run() {
            	System.out.println("========="+sdf.format(new Date()));
            	this.cancel();
            }
        },1000,5*1000);
    }
}

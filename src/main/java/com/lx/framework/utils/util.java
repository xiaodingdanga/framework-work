package com.lx.framework.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class util {

	static Logger log = LogManager.getLogger(util.class.getName());

	/**
	 * 获取UUID
	 * 
	 * @return
	 */
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		return uuid;
	}

	/**
	 * 获取日期加四位随机订单号
	 */
	public static String getcode4() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String code = sdf.format(date);
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			code += random.nextInt(10);
		}
		return code;
	}

	/**
	 * 获取日期加五位随机订单号
	 */
	public static String getcode5() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String code = sdf.format(date);
		Random random = new Random();
		for (int i = 0; i < 5; i++) {
			code += random.nextInt(10);
		}
		return code;
	}

	/**
	 * 获取属性显示类型中文名
	 * 
	 * @param deftype
	 * @return
	 */
	public static String getShowtype(String showtype) {
		String ret = "";
		switch (showtype) {
		case "1":
			ret += "查询显示,";
			break;
		}
		if (!ret.equals("")) {
			ret = ret.substring(0, ret.length() - 1);
		}
		return ret;
	}

	/**
	 * 当前日期
	 */
	public static String today() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}

	/**
	 * 日期类型数据格式化
	 * 
	 * @return
	 * @throws ParseException
	 */
	public static String stringformat(String date, String format) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date d = sdf.parse(date);
		return sdf.format(d);
	}

	/**
	 * Date 转换为 String
	 * 
	 * @param date
	 * @return
	 */
	public static String datetostring(Date date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	/**
	 * 验证是否正整数
	 * 
	 * @param value
	 * @return
	 */
	public static boolean isint(String value) {
		String zz = "^\\d+$";
		Pattern p = Pattern.compile(zz);
		Matcher m = p.matcher(value);
		return m.find();
	}

	/**
	 * 时间字符串转long
	 * 
	 * @param date
	 * @param format
	 * @return
	 * @throws ParseException
	 */
	public static long getDateToLong(String date, String format) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date d = sdf.parse(date);
		return d.getTime();
	}

	/**
	 * 验证是否浮点数
	 * 
	 * @param value
	 * @return
	 */
	public static boolean isdouble(String value) {
		String zz = "^\\d+(.\\d{0,2})|\\d$";
		Pattern p = Pattern.compile(zz);
		Matcher m = p.matcher(value);
		return m.find();
	}

	/**
	 * 验证日期格式--yyyy-MM-dd
	 * 
	 * @param value
	 * @return
	 */
	public static boolean dateformat(String value) {
		String zz = "[1-9]*\\d{3}\\-([0][1-9]|[1][0-2])\\-([0-2][1-9]|[1-3][0-1])";
		Pattern p = Pattern.compile(zz);
		Matcher m = p.matcher(value);
		return m.find();
	}

	/**
	 * String转Calendar
	 * 
	 * @param datestring
	 * @return
	 * @throws ParseException
	 */
	public static Calendar StringToCalendar(String datestring) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(datestring);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar;
	}

	/**
	 * Calendar转String
	 * 
	 * @param calendardate
	 * @return
	 */
	public static String CalendarToString(Calendar calendardate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(calendardate.getTime());
		return date;
	}

	/**
	 * 返回日期是星期几
	 * 
	 * @param calendardate
	 * @return
	 */
	public static String getWeekOfDate(Calendar calendardate) {
		return calendardate.get(Calendar.DAY_OF_WEEK) + "";
	}

	/**
	 * Float转String
	 * 
	 * @param f
	 * @return
	 */
	public static String FloatToString(float f) {
		// 构造方法的字符格式这里如果小数不足2位,会以0补足.
		DecimalFormat decimalFormat = new DecimalFormat(".00");
		return decimalFormat.format(f);// format 返回的是字符串
	}

	public static void main(String[] args) throws Exception {
		String s = "2524b360453d4e19881e20f83b035d88";
		System.out.println(s);
		String ss[]=s.split(",");
		for (int i = 0; i < ss.length; i++) {
			System.out.println(ss[i]);
		}
		
	
	}
}
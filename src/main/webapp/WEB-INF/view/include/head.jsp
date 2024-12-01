<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctx=request.getContextPath(); %>

<!-- 告诉浏览器响应屏幕宽度 -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- ALL--CSS--START-->
<!-- jQuery UI -->
<link rel="stylesheet" href="<%=ctx %>/static/css/jQueryUI/jquery-ui.css">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="<%=ctx %>/static/css/bootstrap.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="<%=ctx %>/static/css/font-awesome/font-awesome.css">
<!-- Ionicons
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css"> -->
<!-- Theme style -->
<link rel="stylesheet" href="<%=ctx %>/static/css/AdminLTE.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="<%=ctx %>/static/css/_all-skins.css">
<!-- iCheck 
<link rel="stylesheet" href="<%=ctx %>/static/css/iCheck/blue.css">-->
<!-- Morris chart
<link rel="stylesheet" href="<%=ctx %>/static/css/morris/morris.css"> -->
<!-- jvectormap 
<link rel="stylesheet" href="<%=ctx %>/static/css/jvectormap/jquery-jvectormap-1.2.2.css">-->
<!-- Date Picker 
<link rel="stylesheet" href="<%=ctx %>/static/css/datepicker/datepicker3.css">-->
<!-- Daterange picker 
<link rel="stylesheet" href="<%=ctx %>/static/css/daterangepicker/daterangepicker-bs3.css">-->
<!-- bootstrap wysihtml5 - text editor 
<link rel="stylesheet" href="<%=ctx %>/static/css/bootstrap-wysihtml5/bootstrap3-wysihtml5.css">-->
<!-- jqGrid -->
<link rel="stylesheet" href="<%=ctx %>/static/css/jqGrid/ui.jqgrid.css">
<!-- 公共css -->
<link rel="stylesheet" href="<%=ctx %>/static/css/style.css">
<!-- zTree -->
<link rel="stylesheet" href="<%=ctx %>/static/css/zTree/zTreeStyle.css">
<!-- multiselect -->
<link rel="stylesheet" href="<%=ctx %>/static/css/multiselect/jquery.multiselect.css">
<!-- colpick -->
<link rel="stylesheet" href="<%=ctx %>/static/css/colpick/colpick.css">
<!-- fileinput -->
<link rel="stylesheet" href="<%=ctx %>/static/css/fileinput/fileinput.css">
<!-- ALL--CSS--END-->
<!-- -----------------------------------------------------------CSS/JS-美分割线--------------------------------------------------------------- -->
<!-- ALL--JS--START-->
<!-- jQuery 2.2.0 -->
<script src="<%=ctx %>/static/js/jQuery/jQuery-2.2.0.min.js"></script>
<!-- jQuery UI -->
<script src="<%=ctx %>/static/js/jQueryUI/jquery-ui.js"></script>
<script src="<%=ctx %>/static/js/jquery.form.js"></script>
<script src="<%=ctx %>/static/js/jquery.md5.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip 
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>-->
<!-- Bootstrap 3.3.6 -->
<script src="<%=ctx %>/static/js/bootstrap.js"></script>
<!-- Morris.js charts
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script> 
<script src="<%=ctx %>/static/js/morris/morris.js"></script>-->
<!-- Sparkline 
<script src="<%=ctx %>/static/js/sparkline/jquery.sparkline.js"></script>-->
<!-- jvectormap 
<script src="<%=ctx %>/static/js/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="<%=ctx %>/static/js/jvectormap/jquery-jvectormap-world-mill-en.js"></script>-->
<!-- jQuery Knob Chart
<script src="<%=ctx %>/static/js/knob/jquery.knob.js"></script> -->
<!-- daterangepicker
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="<%=ctx %>/static/js/daterangepicker/daterangepicker.js"></script> -->
<!-- datepicker
<script src="<%=ctx %>/static/js/datepicker/bootstrap-datepicker.js"></script> -->
<!-- Bootstrap WYSIHTML5
<script src="<%=ctx %>/static/js/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.js"></script> -->
<!-- Slimscroll -->
<script src="<%=ctx %>/static/js/slimScroll/jquery.slimscroll.js"></script>
<!-- FastClick
<script src="<%=ctx %>/static/js/fastclick/fastclick.js"></script> -->
<!-- AdminLTE App -->
<script src="<%=ctx %>/static/js/app.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) 
<script src="<%=ctx %>/static/js/pages/dashboard.js"></script>-->
<!-- jqGrid -->
<script src="<%=ctx %>/static/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="<%=ctx %>/static/js/jqGrid/i18n/grid.locale-cn.js"></script>
<!-- zTree -->
<script src="<%=ctx %>/static/js/zTree/jquery.ztree.core.min.js"></script>
<script src="<%=ctx %>/static/js/zTree/jquery.ztree.excheck.min.js"></script>
<script src="<%=ctx %>/static/js/zTree/jquery.ztree.exedit.min.js"></script>
<!-- zDialog -->
<script src="<%=ctx %>/static/js/zDialog/zDialog.js"></script>
<script src="<%=ctx %>/static/js/zDialog/zDrag.js"></script>
<!-- validate -->
<script src="<%=ctx %>/static/js/validate/jquery.validate.min.js"></script>
<script src="<%=ctx %>/static/js/validate/messages_cn.js"></script>
<!-- My97DatePicker -->
<script src="<%=ctx %>/static/js/My97DatePicker/WdatePicker.js"></script>
<!-- 公共JS -->
<script src="<%=ctx %>/static/js/util.js"></script>
<!-- multiselect -->
<script src="<%=ctx %>/static/js/multiselect/jquery.multiselect.js"></script>
<!-- highchars -->
<script src="<%=ctx %>/static/js/highchars/highcharts.js"></script>
<script src="<%=ctx %>/static/js/highchars/highcharts-3d.js"></script>
<script src="<%=ctx %>/static/js/highchars/exporting.src.js"></script>
<script src="<%=ctx %>/static/js/highchars/export-excel.js"></script>
<!-- webcam -->
<script src="<%=ctx %>/static/js/jquery.webcam.min.js"></script>
<!-- jQueryPrint -->
<%-- <script src="<%=ctx %>/static/js/jQueryPrint/jquery.jqprint-0.3.js"></script> --%>
<%-- <script src="<%=ctx %>/static/js/jQueryPrint/jquery-migrate-1.2.1.min.js"></script> --%>
<!-- fileinput -->
<script src="<%=ctx %>/static/js/fileinput/fileinput.js"></script>
<script src="<%=ctx %>/static/js/locales/zh.js"></script>
<!-- lodop -->
<%-- <script src="<%=ctx %>/static/js/lodop/LodopFuncs.js"></script> --%>
<script src="<%=ctx %>/static/js/highchars/export-excel.js"></script>
<!-- 购物车 -->
<script src="<%=ctx %>/static/js/jquery.fly.min.js"></script>
<script src="<%=ctx %>/static/js/requestAnimationFrame.js"></script>
<!-- ALL--JS--END-->
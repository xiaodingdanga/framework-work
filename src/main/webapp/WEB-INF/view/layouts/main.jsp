<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<% String ctx=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>${proname}</title>
    <jsp:include page="/WEB-INF/view/include/head.jsp"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
	<jsp:include page="/WEB-INF/view/layouts/top.jsp"/>
	<jsp:include page="/WEB-INF/view/layouts/left.jsp"/>
  	<!-- main start -->
  	<!-- Content Wrapper. Contains page content -->
  	<div class="content-wrapper">
    	<!-- Content Header (Page header)-->
    	<section class="content-header"> 
	      	<!-- <h1>Dashboard<small>Control panel</small></h1> -->
	      	<ol class="breadcrumb">
	      		<li><a href="#" title="首页"><i class="fa fa-home"></i></a></li>
	      		${title}
<!-- 	        	<li><a href="#">系统管理</a></li> -->
<!-- 	        	<li class="active">用户管理</li> -->
	      	</ol>
    	</section>
    	<!-- Main content -->
    	<section class="content">
    		<!-- 被装饰的内容 -->
    		<sitemesh:write property="body"/>
    	</section>
  	</div>
  	<!-- main end -->
  	<jsp:include page="/WEB-INF/view/layouts/bottom.jsp"/>
	
  	<!-- Control Sidebar -->
  	<aside class="control-sidebar control-sidebar-dark">
    	<!-- Create the tabs -->
    	<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
    		<li class="active"><a href="#control-sidebar-theme-demo-options-tab" data-toggle="tab" aria-expanded="true"><i class="fa fa-wrench"></i></a></li>
      		<!-- <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li> -->
    	</ul>
    	<!-- Tab panes -->
    	<div class="tab-content">
    		<!-- 样式设置start -->
    		<div id="control-sidebar-theme-demo-options-tab" class="tab-pane active">
    			<div>
    				<!-- 
    				<h4 class="control-sidebar-heading">布局选项</h4>
    				
    				<div class="form-group">
    					<label class="control-sidebar-subheading">
    						<input type="checkbox" data-layout="fixed" class="pull-right">固定布局
    					</label>
    					<p>不能与盒装布局一起使用</p>
    				</div>
    				
    				<div class="form-group">
    					<label class="control-sidebar-subheading">
    						<input type="checkbox" data-layout="layout-boxed" class="pull-right"> 盒装布局
    					</label>
    					<p>激活盒装布局</p>
    				</div>
    				<div class="form-group">
    					<label class="control-sidebar-subheading">
    						<input type="checkbox" data-layout="sidebar-collapse" class="pull-right">导航栏
    					</label>
    					<p>导航栏状态(展开/合并)</p>
    				</div>
    				
    				<div class="form-group">
    					<label class="control-sidebar-subheading">
    						<input type="checkbox" data-enable="expandOnHover" class="pull-right"> Sidebar Expand on Hover
    					</label>
    					<p>Let the sidebar mini expand on hover</p>
    				</div> 
    				<div class="form-group">
    					<label class="control-sidebar-subheading">
    						<input type="checkbox" data-controlsidebar="control-sidebar-open" class="pull-right"> Toggle Right Sidebar Slide
    					</label>
    					<p>Toggle between slide over content and push content effects</p>
    				</div>
    				<div class="form-group">
    					<label class="control-sidebar-subheading">
    						<input type="checkbox" data-sidebarskin="toggle" class="pull-right">右侧导航栏皮肤
    					</label>
    					<p>切换右侧导航栏皮肤</p>
    				</div>-->
    				<h4 class="control-sidebar-heading">皮肤</h4>
    				<ul class="list-unstyled clearfix">
    					<li style="float:left; width: 33.33333%; padding: 5px;">
	    					<a href="javascript:void(0);" data-skin="skin-blue" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
	    						<div>
	    							<span style="display:block; width: 20%; float: left; height: 7px; background: #367fa9;"></span>
	    							<span class="bg-light-blue" style="display:block; width: 80%; float: left; height: 7px;"></span>
	    						</div>
	    						<div>
	    							<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
	    							<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
	    						</div>
	    					</a>
	    					<p class="text-center no-margin">蓝色</p>
    					</li>
    					<li style="float:left; width: 33.33333%; padding: 5px;">
    						<a href="javascript:void(0);" data-skin="skin-black" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
    							<div style="box-shadow: 0 0 2px rgba(0,0,0,0.1)" class="clearfix">
    								<span style="display:block; width: 20%; float: left; height: 7px; background: #fefefe;"></span>
    								<span style="display:block; width: 80%; float: left; height: 7px; background: #fefefe;"></span>
    							</div>
    							<div>
    								<span style="display:block; width: 20%; float: left; height: 20px; background: #222;"></span>
    								<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
    							</div>
    						</a>
    						<p class="text-center no-margin">白色</p>
    					</li>
    					<li style="float:left; width: 33.33333%; padding: 5px;">
    						<a href="javascript:void(0);" data-skin="skin-purple" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
    							<div>
    								<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-purple-active"></span>
    								<span class="bg-purple" style="display:block; width: 80%; float: left; height: 7px;"></span>
    							</div>
    							<div>
    								<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
    								<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
    							</div>
    						</a>
    						<p class="text-center no-margin">紫色</p>
    					</li>
    					<li style="float:left; width: 33.33333%; padding: 5px;">
    						<a href="javascript:void(0);" data-skin="skin-green" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
	    						<div>
	    							<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-green-active"></span>
	    							<span class="bg-green" style="display:block; width: 80%; float: left; height: 7px;"></span>
	    						</div>
	    						<div>
	    							<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
	    							<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
	    						</div>
	    					</a>
	    					<p class="text-center no-margin">绿色</p>
	    				</li>
	    				<li style="float:left; width: 33.33333%; padding: 5px;">
	    					<a href="javascript:void(0);" data-skin="skin-red" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
	    						<div>
	    							<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-red-active"></span>
	    							<span class="bg-red" style="display:block; width: 80%; float: left; height: 7px;"></span>
	    						</div>
    							<div>
	    							<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
	    							<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
    							</div>
   							</a>
   							<p class="text-center no-margin">红色</p>
						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
   							<a href="javascript:void(0);" data-skin="skin-yellow" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
	   							<div>
	   								<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-yellow-active"></span>
	   								<span class="bg-yellow" style="display:block; width: 80%; float: left; height: 7px;"></span>
	   							</div>
	   							<div>
	   								<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
	   								<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
	   							</div>
   							</a>
   							<p class="text-center no-margin">黄色</p>
   						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
							<a href="javascript:void(0);" data-skin="skin-blue-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
								<div>
									<span style="display:block; width: 20%; float: left; height: 7px; background: #367fa9;"></span>
									<span class="bg-light-blue" style="display:block; width: 80%; float: left; height: 7px;"></span>
								</div>
								<div>
									<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
									<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
								</div>
							</a>
							<p class="text-center no-margin" style="font-size: 12px">蓝白</p>
						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
							<a href="javascript:void(0);" data-skin="skin-black-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
								<div style="box-shadow: 0 0 2px rgba(0,0,0,0.1)" class="clearfix">
									<span style="display:block; width: 20%; float: left; height: 7px; background: #fefefe;"></span>
									<span style="display:block; width: 80%; float: left; height: 7px; background: #fefefe;"></span>
								</div>
								<div>
									<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
									<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
								</div>
							</a>
							<p class="text-center no-margin" style="font-size: 12px">全白</p>
						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
							<a href="javascript:void(0);" data-skin="skin-purple-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
								<div>
									<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-purple-active"></span>
									<span class="bg-purple" style="display:block; width: 80%; float: left; height: 7px;"></span>
								</div>
								<div>
									<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
									<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
								</div>
							</a>
							<p class="text-center no-margin" style="font-size: 12px">紫白</p>
						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
							<a href="javascript:void(0);" data-skin="skin-green-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
								<div>
									<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-green-active"></span>
									<span class="bg-green" style="display:block; width: 80%; float: left; height: 7px;"></span>
								</div>
								<div>
									<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
									<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
								</div>
							</a>
							<p class="text-center no-margin" style="font-size: 12px">绿白</p>
						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
							<a href="javascript:void(0);" data-skin="skin-red-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
								<div>
									<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-red-active"></span>
									<span class="bg-red" style="display:block; width: 80%; float: left; height: 7px;"></span>
								</div>
								<div>
									<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
									<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
								</div>
							</a>
							<p class="text-center no-margin" style="font-size: 12px">红白</p>
						</li>
						<li style="float:left; width: 33.33333%; padding: 5px;">
							<a href="javascript:void(0);" data-skin="skin-yellow-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
								<div>
									<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-yellow-active"></span>
									<span class="bg-yellow" style="display:block; width: 80%; float: left; height: 7px;"></span>
								</div>
								<div>
									<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
									<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
								</div>
							</a>
							<p class="text-center no-margin" style="font-size: 12px;">黄白</p>
						</li>
					</ul>
				</div>
			</div>
      		
      		<!-- Stats tab content
      		<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div> -->
      		<!-- /.tab-pane -->
      		<!-- Settings tab content
      		<div class="tab-pane" id="control-sidebar-settings-tab">
        		<form method="post">
          			<h3 class="control-sidebar-heading">General Settings</h3>
          			<div class="form-group">
            			<label class="control-sidebar-subheading">
              				Report panel usage<input type="checkbox" class="pull-right" checked>
            			</label>
            			<p>Some information about this general settings option</p>
          			</div>
          			<div class="form-group">
            			<label class="control-sidebar-subheading">
              				Allow mail redirect<input type="checkbox" class="pull-right" checked>
            			</label>
						<p>Other sets of options are available</p>
          			</div>
          			<div class="form-group">
            			<label class="control-sidebar-subheading">
              				Expose author name in posts<input type="checkbox" class="pull-right" checked>
            			</label>
			            <p>Allow the user to show his name in blog posts</p>
          			</div>
          			<h3 class="control-sidebar-heading">Chat Settings</h3>
          			<div class="form-group">
            			<label class="control-sidebar-subheading">
              				Show me as online<input type="checkbox" class="pull-right" checked>
            			</label>
          			</div>
          			<div class="form-group">
            			<label class="control-sidebar-subheading">
              				Turn off notifications<input type="checkbox" class="pull-right">
            			</label>
          			</div>
          			<div class="form-group">
            			<label class="control-sidebar-subheading">
              				Delete chat history<a href="javascript:void(0)" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
            			</label>
          			</div>
        		</form>
      		</div> -->
    	</div>
  	</aside>
  	<!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
  	<div class="control-sidebar-bg"></div>
</div>
</body>
<!-- AdminLTE for demo purposes -->
<script src="<%=ctx %>/static/js/demo.js"></script>
</html>
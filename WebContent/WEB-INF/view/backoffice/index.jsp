<%
/**
 * YOU ARE STRICTLY PROHIBITED TO COPY, DISCLOSE, DISTRIBUTE, MODIFY OR USE THIS PROGRAM
 * IN PART OR AS A WHOLE WITHOUT THE PRIOR WRITTEN CONSENT OF HIMEDIA.CO.KR.
 * HIMEDIA.CO.KR OWNS THE INTELLECTUAL PROPERTY RIGHTS IN AND TO THIS PROGRAM.
 * COPYRIGHT (C) 2024 HIMEDIA.CO.KR ALL RIGHTS RESERVED.
 *
 * 하기 프로그램에 대한 저작권을 포함한 지적재산권은 himedia.co.kr에 있으며,
 * himedia.co.kr이 명시적으로 허용하지 않는 사용, 복사, 변경 및 제 3자에 의한 공개, 배포는 엄격히 금지되며
 * himedia.co.kr의 지적재산권 침해에 해당된다.
 * Copyright (C) 2024 himedia.co.kr All Rights Reserved.
 *
 *
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			:
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241023170000][dhtjgml87@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/WEB-INF/view/backoffice/index.jsp"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/include/console/header.jsp" %>
	
	<script>
		window.onload = function() {
			// [TODO: 방문자수 출력하기]
			var date = new Date();
			var _year = date.getFullYear();
			var _month = date.getMonth() + 1;
			
			$("strong.month_visitor").text(_month + "월 방문자");

			/* DONUT 차트 */
			var _label = [];	// 판매자명
			var _value = [];	// 상품수
			<c:forEach items="${saleList}" var="saleList" varStatus="status">
				var per = ${saleList.sale} / ${sale} * 100;
				$(".cirStats > div > div").eq(${status.index}).find("h4").text("${saleList.sll_nm}");
				$(".cirStats > div > div").eq(${status.index}).find(".percent").text(Math.ceil(per) + "%");
				_label.push('${saleList.sll_nm}');
				_value.push('${saleList.sale}');
			</c:forEach>
			
			Morris.Donut({
				element: 'morris-donut-chart',
				data: [
					{
						label: _label[0],
						value: _value[0]
					}, {
						label: _label[1],
						value: _value[1]
					}, {
						label: _label[2],
						value: _value[2]
					}, {
						label: _label[3],
						value: _value[3]
					}
				],
				colors: [
					'#414e63', '#e96562', '#4CAF50', '#A6A6A6'
				],
				resize: true
			})

			/* LINE 차트 */
			var _yData = [];	// 년월
			var _aData = [];	// 방문자수
			<c:forEach items="${visitorList}" var="visitorList">
				_yData.push('${visitorList.year}-${visitorList.month}');
				_aData.push(${visitorList.visitor});
			</c:forEach>
			
			Morris.Line({
				element: 'morris-line-chart',
				data: [
					{ y: _yData[0],  a: _aData[0]},
					{ y: _yData[1],  a: _aData[1]},
					{ y: _yData[2],  a: _aData[2]},
					{ y: _yData[3],  a: _aData[3]},
					{ y: _yData[4],  a: _aData[4]},
					{ y: _yData[5],  a: _aData[5]},
					{ y: _yData[6],  a: _aData[6]},
					{ y: _yData[7],  a: _aData[7]},
					{ y: _yData[8],  a: _aData[8]},
					{ y: _yData[9],  a: _aData[9]},
					{ y: _yData[10], a: _aData[10]},
					{ y: _yData[11], a: _aData[11]}
				],
			
				xkey: 'y',
				ykeys: ['a'],
				labels: ['방문자수'],
				fillOpacity: 0.6,
				hideHover: 'auto',
				behaveLikeLine: true,
				resize: true,
				pointFillColors:['#ffffff'],
				pointStrokeColors: ['black'],
				lineColors:['gray']
			});
			
			/* BAR 차트 */
			var today = _year + "-" + _month.toString().padStart(2, '0');
			var _mData = [];		// 년월
			var _joinData = [];		// 가입자수
			var _outData = [];		// 탈퇴자수
			var pastMonth = new Date(date.setMonth(date.getMonth() + 1));
			var num = 0;
			var num2 = 0;
			for (var i = 1; i > -4; i--) {
				if (i == 1) {
					var pastMonth = new Date(pastMonth.setMonth(pastMonth.getMonth()));
				} else {
					var pastMonth = new Date(pastMonth.setMonth(pastMonth.getMonth() - 1));
				}
				_pastMonth = pastMonth.getFullYear() + "-" + pastMonth.getMonth().toString().padStart(2, '0');
				_mData.push(_pastMonth);

				<c:forEach items="${joinList}" var="joinList">
					if (_pastMonth == '${joinList.dt_reg}') {
						_joinData[num] = '${joinList.seq_mbr}';
					} else {
						if (_joinData[num] == null) {
							_joinData[num] = 0;
						}
					}
				</c:forEach>
				num++;
				
				<c:forEach items="${outList}" var="outList">
					if (_pastMonth == '${outList.dt_reg}') {
						_outData[num2] = '${outList.seq_mbr}';
					} else {
						if (_outData[num2] == null) {
							_outData[num2] = 0;
						}
					}
				</c:forEach>
				num2++;
			}
			
			Morris.Bar({
				element: 'morris-bar-chart',
				data: [
				{
					m: _mData[4],
					a: _joinData[4],
					b: _outData[4]
				}, {
					m: _mData[3],
					a: _joinData[3],
					b: _outData[3]
				}, {
					m: _mData[2],
					a: _joinData[2],
					b: _outData[2]
				}, {
					m: _mData[1],
					a: _joinData[1],
					b: _outData[1]
				}, {
					m: _mData[0],
					a: _joinData[0],
					b: _outData[0]
				}],
				xkey: 'm',
				ykeys: ['a', 'b'],
				labels: ['가입', '탈퇴'],
				barColors: [
					'#e96562','#414e63','#A8E9DC' 
				],
				hideHover: 'auto',
				resize: true
			});
			
			/* AREA 차트*/
			var today = _year + "-" + _month.toString().padStart(2, '0');
			var _pData = [];		// 년월
			var _cdData = [0,0,0,0,0,0,0,0,0,0];		// 꼼데가르송
			var _laData = [0,0,0,0,0,0,0,0,0,0];		// 라코스테
			var _lvData = [0,0,0,0,0,0,0,0,0,0];		// 리바이스
			var _bpData = [0,0,0,0,0,0,0,0,0,0];		// 빈폴
			
			var pastMonth = new Date(date.setMonth(date.getMonth()));
			for (var i = 1; i > -9; i--) {
				if (i == 1) {
					var pastMonth = new Date(pastMonth.setMonth(pastMonth.getMonth()));
				} else {
					var pastMonth = new Date(pastMonth.setMonth(pastMonth.getMonth() - 1));
				}
				_pastMonth = pastMonth.getFullYear() + "-" + pastMonth.getMonth().toString().padStart(2, '0');
				_pData.push(_pastMonth);
			}
			
			<c:forEach items="${salesList}" var="salesList" varStatus="index">
				var pastMonth = new Date(date.setMonth(date.getMonth()));
				var num = 0;
				for (var i = 1; i > -9; i--) {
					if (i == 1) {
						var pastMonth = new Date(pastMonth.setMonth(pastMonth.getMonth()));
					} else {
						var pastMonth = new Date(pastMonth.setMonth(pastMonth.getMonth() - 1));
					}
					//_pastMonth = pastMonth.getFullYear() + "-" + pastMonth.getMonth().toString().padStart(2, '0');
					
					if (_pData[num] == '${salesList.period}') {
						if ('${salesList.sll_nm}' == '꼼데가르송') {
							_cdData[num] = '${salesList.priceTotal}';
							break;
						}
						if ('${salesList.sll_nm}' == '라코스테') {
							_laData[num] = '${salesList.priceTotal}';
							break;
						}
						if ('${salesList.sll_nm}' == '리바이스') {
							_lvData[num] = '${salesList.priceTotal}';
							break;
						}
						if ('${salesList.sll_nm}' == '빈폴') {
							_bpData[num] = '${salesList.priceTotal}';
							break;
						}
					}
					num++;
				}
			</c:forEach>
			
			Morris.Area({
				element: 'morris-area-chart',
				data: [{
					period:	 	_pData[0],
					commedes:	_cdData[0],
					lacoste:	_laData[0],
					levis: 		_lvData[0],
					beanpole:	_bpData[0]
				}, {
					period:	 	_pData[1],
					commedes:	_cdData[1],
					lacoste:	_laData[1],
					levis: 		_lvData[1],
					beanpole:	_bpData[1]
				}, {
					period:	 	_pData[2],
					commedes:	_cdData[2],
					lacoste:	_laData[2],
					levis: 		_lvData[2],
					beanpole:	_bpData[2]
				}, {
					period:	 	_pData[3],
					commedes:	_cdData[3],
					lacoste:	_laData[3],
					levis: 		_lvData[3],
					beanpole:	_bpData[3]
				}, {
					period:	 	_pData[4],
					commedes:	_cdData[4],
					lacoste:	_laData[4],
					levis: 		_lvData[4],
					beanpole:	_bpData[4]
				}, {
					period:	 	_pData[5],
					commedes:	_cdData[5],
					lacoste:	_laData[5],
					levis: 		_lvData[5],
					beanpole:	_bpData[5]
				}, {
					period:	 	_pData[6],
					commedes:	_cdData[6],
					lacoste:	_laData[6],
					levis: 		_lvData[6],
					beanpole:	_bpData[6]
				}, {
					period:	 	_pData[7],
					commedes:	_cdData[7],
					lacoste:	_laData[7],
					levis: 		_lvData[7],
					beanpole:	_bpData[7]
				}, {
					period:	 	_pData[8],
					commedes:	_cdData[8],
					lacoste:	_laData[8],
					levis: 		_lvData[8],
					beanpole:	_bpData[8]
				}, {
					period:	 	_pData[9],
					commedes:	_cdData[9],
					lacoste:	_laData[9],
					levis: 		_lvData[9],
					beanpole:	_bpData[9]
				}],
				xkey: 'period',
				ykeys: ['commedes', 'levis', 'beanpole', 'lacoste'],
				labels: ['꼼데가르송', '리바이스', '빈폴', '라코스테'],
				pointSize: 2,
				hideHover: 'auto',
				  pointFillColors:['#ffffff'],
				  pointStrokeColors: ['black'],
				  lineColors:['#A6A6A6','#414e63'],
				resize: true
			});
		}	
	</script>
</head>

<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		<%@ include file="/include/console/gnb.jsp" %>
	
		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">홈</h1>
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li class="active">Statistical Chart</li>
				</ol>
			</div>
			<div id="page-inner">
				<div class="dashboard-cards">
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-3">
							<div class="card horizontal cardIcon waves-effect waves-dark">
								<div class="card-image red">
									<i class="material-icons dp48">import_export</i>
								</div>
								<div class="card-stacked red">
									<div class="card-content">
										<h3><fmt:formatNumber value="${member}" type="number" /></h3>
									</div>
									<div class="card-action">
										<strong>구매자</strong>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-3">
							<div class="card horizontal cardIcon waves-effect waves-dark">
								<div class="card-image orange">
									<i class="material-icons dp48">shopping_cart</i>
								</div>
								<div class="card-stacked orange">
									<div class="card-content">
										<h3><fmt:formatNumber value="${seller}" type="number" /></h3>
									</div>
									<div class="card-action">
										<strong>판매자</strong>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-3">
							<div class="card horizontal cardIcon waves-effect waves-dark">
								<div class="card-image blue">
									<i class="material-icons dp48">equalizer</i>
								</div>
								<div class="card-stacked blue">
									<div class="card-content">
										<h3><fmt:formatNumber value="${sale}" type="number" /></h3>
									</div>
									<div class="card-action">
										<strong>상품</strong>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-3">
							<div class="card horizontal cardIcon waves-effect waves-dark">
								<div class="card-image green">
									<i class="material-icons dp48">supervisor_account</i>
								</div>
								<div class="card-stacked green">
									<div class="card-content">
										<h3 class="month_visitor"><fmt:formatNumber value="${visit}" type="number" /></h3>
									</div>
									<div class="card-action">
										<strong class="month_visitor"></strong>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /. ROW  -->
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-7"> 
						<div class="cirStats">
							<div class="row">
								<%-- 판매자별 판매 상품수 비율--%>
								<c:forEach items="${saleList}" var="saleList">
									<c:set var="i" value="${i+1}" />
									<div class="col-xs-12 col-sm-6 col-md-6">
										<div class="card-panel text-center">
											<h4>${saleList.sll_nm}</h4>
											<div class="easypiechart"
												<c:if test="${i == 1}">id="easypiechart-blue"</c:if>
												<c:if test="${i == 2}">id="easypiechart-red"</c:if>
												<c:if test="${i == 3}">id="easypiechart-teal"</c:if>
												<c:if test="${i == 4}">id="easypiechart-orange"</c:if>
												 data-percent="${saleList.sale / sale * 100}">
												<span class="percent">
											</span>
											</div> 
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-5">
						<div class="row">
							<div class="col-xs-12">
								<div class="card">
									<div class="card-image donutpad">
										<div id="morris-donut-chart"></div>
									</div>
									<div class="card-action">
										<b>판매자별 상품 수</b>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/.row-->
				</div>


				<div class="row">
					<div class="col-md-7">
						<div class="card">
							<div class="card-image">
								<div id="morris-line-chart"></div>
							</div>
							<div class="card-action">
								<b>월별 방문자 수</b>
							</div>
						</div>
					</div>
					<div class="col-md-5">
						<div class="card">
							<div class="card-image">
								<div id="morris-bar-chart"></div>
							</div>
							<div class="card-action">
								<b>월별 가입/탈퇴자 수</b>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-xs-12">
						<div class="card">
							<div class="card-image">
								<div id="morris-area-chart"></div>
							</div>
							<div class="card-action">
								<b>판매자별 월 매출</b>
							</div>
						</div>
					</div>
				</div>
				
				<footer>
					<p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
				</footer>
			</div>
			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
</body>
</html>
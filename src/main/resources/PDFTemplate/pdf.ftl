<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="content-type" content="text/html;charset=utf-8"></meta>
<style type="text/css"> 
    body {
        font-family: SimSun;
    }

table {
	page-break-after:always;
	font-size:14px;
	text-align:center;
	width:100%;
	border-top:1px solid #ccc;
	border-left:1px solid #ccc
}

table tr td {
	height:30px;
	font:400 14px/24px;
	border-right:1px solid #ccc;
	border-bottom:1px solid #ccc;
	padding:8px 10px
}

.lifeLine {
	height:21px;
	border-bottom:solid !important;
	border-width:thin !important;
	text-align:center !important;
	display:inline-block
}

.tableStyle1 tr td:first-child,table tr td.tdbg {
	font-weight:600
}

.tableStyle2 tr:first-child {
	background:#eeeeee
}
    
</style>
</head>

<body>
	
	<#-- 1、家庭基本情况 -->
	<table cellpadding="0" cellspacing="0" border="0" class="tableStyle1">
	    <tbody>
	        <tr>
	            <td>户主姓名</td>
	            <td id="holderName">${baseInfo.householderName}</td>
	            <td class="tdbg">性别</td>
	            <td>${baseInfo.gender}</td>
	            <td rowspan="4">户主照片</td>
	        </tr>
	        <tr>
	            <td>家庭人口</td>
	            <td>${baseInfo.populationNum}</td>
	            <td class="tdbg">民族</td>
	            <td>${baseInfo.nationCode}</td>
	        </tr>
	        <tr>
	            <td>出生时间</td>
	            <#-- >td colspan="3">${baseInfo.birthday?string("yyyy年MM月dd日")}</td -->
	            <#-- td colspan="3">${baseInfo.birthday?number?number_to_datetime}</td -->
	            <td colspan="3">${baseInfo.birthday}</td>
	            
	        </tr>
	        <tr>
	            <td>联系电话</td>
	            <td colspan="3">${baseInfo.telNo}</td>
	        </tr>
	        <tr>
	            <td>识别标准</td>
	            <#if baseInfo.poorAttributeCode = "巩固提升户">
	            	<td colspan="4">户年人均纯收入虽超过省定扶贫标准但未稳定或“两不愁三保障”未完全解决</td>
	            <#else>
	            	<td colspan="4">户年人均纯收入低于省定扶贫标准</td>
	            </#if>
	        </tr>
	        <tr>
	            <td>家庭住址</td>
	            <td colspan="4">${baseInfo.address1}&nbsp;${baseInfo.address2}&nbsp;${baseInfo.address3!''}</td>
	        </tr>
	        <tr>
	            <td>贫困户属性</td>
	            <#if baseInfo.poorAttributeCode = "巩固提升户">
	            	<td colspan="4">
	            		${isIndexOf (baseInfo.poorAttributeCode "巩固提升户" "√" "□")}巩固提升户
	            	</td>
	            <#else>
	            	<td colspan="4">
	            		（可复选）：
	            		${isIndexOf (baseInfo.poorAttributeCode "扶贫户" "√" "□")}扶贫户&nbsp;
	            		${isIndexOf (baseInfo.poorAttributeCode "低保户" "√" "□")}低保户&nbsp;
	            		${isIndexOf (baseInfo.poorAttributeCode "五保户" "√" "□")}五保户
					</td>
	            </#if>
	        </tr>
	        <tr>
	            <td>主要致贫原因</td>
	            <td colspan="4">
	                <span style="width: 19mm;">(单选):</span>
	                <span style="width: 24mm;">${isIndexOf (baseInfo.mainPoorCauseCode "因病" "√" "□")}因病</span>
	                <span style="width: 19mm;">${isIndexOf (baseInfo.mainPoorCauseCode "因残" "√" "□")}因残</span>
	                <span style="width: 19mm;">${isIndexOf (baseInfo.mainPoorCauseCode "因学" "√" "□")}因学</span>
	                <span style="width: 19mm;">${isIndexOf (baseInfo.mainPoorCauseCode "因灾" "√" "□")}因灾</span>
	                <span style="width: 23mm;">${isIndexOf (baseInfo.mainPoorCauseCode "缺土地" "√" "□")}缺土地</span>
	                <span style="width: 20mm;">${isIndexOf (baseInfo.mainPoorCauseCode "缺水" "√" "□")}缺水</span>
	                <span style="width: 28mm;">${isIndexOf (baseInfo.mainPoorCauseCode "缺劳动力" "√" "□")}缺劳动力</span>
	                <span style="width: 29mm;">${isIndexOf (baseInfo.mainPoorCauseCode "缺资金" "√" "□")}缺资金</span>
	                <span style="width: 23mm;">${isIndexOf (baseInfo.mainPoorCauseCode "缺技术" "√" "□")}缺技术</span>
	                <span style="width: 32mm;">${isIndexOf (baseInfo.mainPoorCauseCode "交通条件落后" "√" "□")}交通条件落后</span>
	                <span style="">${isIndexOf (baseInfo.mainPoorCauseCode "自身发展动力不足" "√" "□")}自身发展动力不足</span>
	            </td>
	        </tr>
	        <tr>
	            <td>次要致贫原因</td>
	            <td colspan="4" style="width: 102mm;">
	                <span style="width: 19mm;">(多选):</span>
	                <span style="width: 24mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "因病" "√" "□")}因病</span>
					<span style="width: 19mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "因残" "√" "□")}因残</span>
					<span style="width: 19mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "因学" "√" "□")}因学</span>
					<span style="width: 19mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "因灾" "√" "□")}因灾</span>
					
					<span style="width: 23mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "缺土地" "√" "□")}缺土地</span>
					<span style="width: 20mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "缺水" "√" "□")}缺水</span>
					<span style="width: 28mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "缺劳动力" "√" "□")}缺劳动力</span>
					<span style="width: 29mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "缺资金" "√" "□")}缺资金</span>
					
					<span style="width: 23mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "缺技术" "√" "□")}缺技术</span>
					<span style="width: 32mm;">${isIndexOf (baseInfo.secondaryPoorCauseCode "交通条件落后" "√" "□")}交通条件落后</span>
					<span style="width: ;">${isIndexOf (baseInfo.secondaryPoorCauseCode "自身发展动力不足" "√" "□")}自身发展动力不足</span>
	            </td>
	        </tr>
	    </tbody>
	</table>
	
	
	<#-- 生产生活情况 -->
	<div>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle1">
			<tbody>
				<tr>
					<td>耕地面积</td>
					<td style="width: 102mm;" colspan="5">
						<span style="width:50mm;" class="lifeLine"> ${lifeInfo.farmland_fact_area!} </span><span>亩（实际面积）</span>
						<span>其中：确权面积</span>
						<span style="width:14mm;" class="lifeLine"> ${lifeInfo.farmland_right_area!} </span>
						<span>亩，有效灌溉面积</span>
						<span style="width:14mm;" class="lifeLine"> ${lifeInfo.farmland_irrigate_area!} </span><span>亩，</span>
						<span>旱田面积</span><span style="width:14mm;" class="lifeLine"> ${lifeInfo.farmland_dry_area!} </span>
						<span>亩，水田面积</span><span style="width:14mm;" class="lifeLine"> 
							${lifeInfo.farmland_paddy_area!}
						</span><span>亩</span>
					</td>
				</tr>
				<tr>
					<td>林地面积</td>
					<td style="width: 102mm;" colspan="5">
						<span style="width:50mm;" class="lifeLine"> ${lifeInfo.woodland_fact_area!} </span>
						<span>亩（实际面积）</span>
						<span>其中：确权面积</span>
						<span style="width:14mm;" class="lifeLine">${lifeInfo.woodland_right_area!} </span>
						<span>亩，退耕还林面积</span>
						<span style="width:14mm;" class="lifeLine">${lifeInfo.return_to_forest_area!} </span>
						<span>亩</span>
					</td>
				</tr>
				<tr>
					<td>林果面积</td>
					<td style="width: 102mm;" colspan="5">
						<span style="width:50mm;" class="lifeLine">${lifeInfo.fruit_fact_area!} </span>
						<span>亩（实际面积）</span>
						<span>其中：确权面积</span>
						<span style="width:14mm;" class="lifeLine">${lifeInfo.fruit_right_area!} </span>
						<span>亩</span>
					</td>
				</tr>
				<tr>
					<td>水面面积</td>
					<td style="width: 102mm;" colspan="5">
						<span style="width:50mm;" class="lifeLine">${lifeInfo.water_fact_area!} </span>
						<span>亩（实际面积）</span>
						<span>其中：确权面积</span>
						<span style="width:14mm;" class="lifeLine">${lifeInfo.water_right_area!} </span>
						<span>亩</span>
					</td>
				</tr>
				<tr>
					<td>牧草地面积</td>
					<td style="width: 102mm;" colspan="5">
						<span style="width:50mm;" class="lifeLine">${lifeInfo.grassland_fact_area!} </span>
						<span>亩（实际面积）</span>
						<span>其中：确权面积</span>
						<span style="width:14mm;" class="lifeLine">${lifeInfo.grassland_right_area!} </span>
						<span>亩</span>
					</td>
				</tr>
				<tr>
					<td>住房面积</td>
					<td>${lifeInfo.housing_area_info!}${lifeInfo.housing_area_info???string("㎡", "")}</td>
					<td>结构类型</td>
					<td>${lifeInfo.structure_type!}</td>
					<td>是否危房</td>
					<td>
						<span style="width: 19mm;"><#if lifeInfo.danger_house_level! == "2">√<#else>□</#if>否</span>
						<span style="width: 19mm;"><#if lifeInfo.danger_house_level! == "levelC">√<#else>□</#if>C级</span>
						<span style="width: 19mm;"><#if lifeInfo.danger_house_level! == "levelD">√<#else>□</#if>D级</span>
					</td>
				</tr>
				<tr>
					<#if baseInfo.poorAttributeCode = "巩固提升户">
						<td>退出时间</td>
					<#else>
						<td>脱贫时间</td>
					</#if>
					<td style="width: 102mm;" colspan="5">${lifeInfo.out_time!}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<#-- 家庭成员 -->
	<div>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>
					<td style="width: 25mm;">姓名</td>
					<td style="width: 10mm;">与户主关系</td>
					<td style="width: 8mm;">性别</td>
					<td style="width: 8mm;">年龄</td>
					<td style="width: 10mm;">文化程度</td>
					<td style="width: 18mm;">在校生情况</td>
					<td style="width: 10mm;">有无劳动能力</td>
					<td style="width: 18mm;">健康状况或疾病类型</td>
					<td style="width: 75mm;">身份证号码或残疾证号码</td>
					<td style="width: 10mm;">年居住时间</td>
					<td style="width: 10mm;">是否参加新农合</td>
					<td style="width: 10mm;">是否参加新农保</td>
					<td style="width: 10mm;">是否享受低保</td>
				</tr>
				<#list [] as being>
				   
				   <tr style="height: 10mm;">
						<td style="width: 25mm;">高文良</td>
						<td style="width: 10mm;">本人</td>
						<td style="width: 8mm;">男</td>
						<td style="width: 8mm;">51</td>
						<td style="width: 10mm;">初中</td>
						<td style="width: 18mm;">非在校生</td>
						<td style="width: 10mm;">有</td>
						<td style="width: 18mm;">健康</td>
						<td style="width: 75mm;">460200196512074235</td>
						<td style="width: 10mm;"></td>
						<td style="width: 10mm;"></td>
						<td style="width: 10mm;"></td>
						<td style="width: 10mm;"></td>
					</tr>
				</#list>
				
			</tbody>
		</table>
	</div>

	<#-- 成员社会关系 -->
	<div></div>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>
					<td style="width: 25mm;">姓名</td>
					<td style="width: 10mm;">与户主关系</td>
					<td style="width: 8mm;">性别</td>
					<td style="width: 8mm;">年龄</td>
					<td style="width: 10mm;">文化程度</td>
					<td style="width: 18mm;">职业</td>
					<td style="width: 20mm;">健康状况或疾病类型</td>
					<td style="width: 75mm;">身份证号码或残疾证号码</td>
					<td style="width: 30mm;">收入</td>
				</tr>

			</tbody>
		</table>
		<p align='center'>帮扶责任人</p>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>
					<td style="width: 30mm;">姓名</td>
					<td style="width: 30mm;">单位名称</td>
					<td style="width: 20mm;">职务</td>
					<td style="width: 40mm;">联系电话</td>
				</tr>

			</tbody>
		</table>
		<p align='center'>巩固提升需求</p>
		<table cellpadding="0" cellspacing="0" border="0">
			<tbody>
				<tr style="height: 120mm;">
					<td style="width: 122mm;"></td>
				</tr>
			</tbody>
		</table>
		<p align='center'>帮扶计划</p>
		<table cellpadding="0" cellspacing="0" border="0">
			<tbody>
				<tr style="height: 120mm;">
					<td style="width: 122mm;"></td>
				</tr>
			</tbody>
		</table>
		<p align='center'>帮扶措施</p>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>
					<td style="width: 12mm;">项目类别</td>
					<td style="width: 30mm;">帮扶单位</td>
					<td style="width: 50mm;">帮扶内容及成本</td>
					<td style="width: 24mm;">帮扶时间</td>
					<td style="width: 12mm;">户主签名</td>
				</tr>

				<tr>

					<td style="width: 12mm;" rowspan="10">产业扶贫</td>

					<td style="width: 30mm;" id="t1_0"></td>
					<td style="width: 50mm;" id="t2_0"></td>
					<td style="width: 24mm;" id="t3_0"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_1"></td>
					<td style="width: 50mm;" id="t2_1"></td>
					<td style="width: 24mm;" id="t3_1"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_2"></td>
					<td style="width: 50mm;" id="t2_2"></td>
					<td style="width: 24mm;" id="t3_2"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_3"></td>
					<td style="width: 50mm;" id="t2_3"></td>
					<td style="width: 24mm;" id="t3_3"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_4"></td>
					<td style="width: 50mm;" id="t2_4"></td>
					<td style="width: 24mm;" id="t3_4"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_5"></td>
					<td style="width: 50mm;" id="t2_5"></td>
					<td style="width: 24mm;" id="t3_5"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_6"></td>
					<td style="width: 50mm;" id="t2_6"></td>
					<td style="width: 24mm;" id="t3_6"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_7"></td>
					<td style="width: 50mm;" id="t2_7"></td>
					<td style="width: 24mm;" id="t3_7"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_8"></td>
					<td style="width: 50mm;" id="t2_8"></td>
					<td style="width: 24mm;" id="t3_8"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 30mm;" id="t1_9"></td>
					<td style="width: 50mm;" id="t2_9"></td>
					<td style="width: 24mm;" id="t3_9"></td>
					<td style="width: 12mm;"></td>
				</tr>

			</tbody>
		</table>
		<p align='center'>帮扶措施</p>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>

					<td style="width: 12mm;">项目类别</td>
					<td style="width: 30mm;">帮扶单位</td>
					<td style="width: 50mm;">帮扶内容及成本</td>
					<td style="width: 24mm;">帮扶时间</td>
					<td style="width: 12mm;">户主签名</td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">教育扶持</td>

					<td style="width: 30mm;" id="tt1_1"></td>
					<td style="width: 50mm;" id="tt2_1"></td>
					<td style="width: 24mm;" id="tt3_1"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">医疗扶持</td>

					<td style="width: 30mm;" id="tt1_2"></td>
					<td style="width: 50mm;" id="tt2_2"></td>
					<td style="width: 24mm;" id="tt3_2"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">危房改造</td>

					<td style="width: 30mm;" id="tt1_3"></td>
					<td style="width: 50mm;" id="tt2_3"></td>
					<td style="width: 24mm;" id="tt3_3"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">劳动力转移</td>

					<td style="width: 30mm;" id="tt1_4"></td>
					<td style="width: 50mm;" id="tt2_4"></td>
					<td style="width: 24mm;" id="tt3_4"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">惠农补贴</td>

					<td style="width: 30mm;" id="tt1_5"></td>
					<td style="width: 50mm;" id="tt2_5"></td>
					<td style="width: 24mm;" id="tt3_5"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">库区移民</td>

					<td style="width: 30mm;" id="tt1_6"></td>
					<td style="width: 50mm;" id="tt2_6"></td>
					<td style="width: 24mm;" id="tt3_6"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">养老保险</td>

					<td style="width: 30mm;" id="tt1_7"></td>
					<td style="width: 50mm;" id="tt2_7"></td>
					<td style="width: 24mm;" id="tt3_7"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">低保金</td>

					<td style="width: 30mm;" id="tt1_8"></td>
					<td style="width: 50mm;" id="tt2_8"></td>
					<td style="width: 24mm;" id="tt3_8"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">生态补偿</td>

					<td style="width: 30mm;" id="tt1_9"></td>
					<td style="width: 50mm;" id="tt2_9"></td>
					<td style="width: 24mm;" id="tt3_9"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">社会捐赠</td>

					<td style="width: 30mm;" id="tt1_10"></td>
					<td style="width: 50mm;" id="tt2_10"></td>
					<td style="width: 24mm;" id="tt3_10"></td>
					<td style="width: 12mm;"></td>
				</tr>

			</tbody>
		</table>
		<p align='center'>帮扶措施</p>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>

					<td style="width: 12mm;">项目类别</td>
					<td style="width: 30mm;">帮扶单位</td>
					<td style="width: 50mm;">帮扶内容及成本</td>
					<td style="width: 24mm;">帮扶时间</td>
					<td style="width: 12mm;">户主签名</td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">教育扶持</td>

					<td style="width: 30mm;" id="ttt1_1"></td>
					<td style="width: 50mm;" id="ttt2_1"></td>
					<td style="width: 24mm;" id="ttt3_1"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">医疗扶持</td>

					<td style="width: 30mm;" id="ttt1_2"></td>
					<td style="width: 50mm;" id="ttt2_2"></td>
					<td style="width: 24mm;" id="ttt3_2"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">危房改造</td>

					<td style="width: 30mm;" id="ttt1_3"></td>
					<td style="width: 50mm;" id="ttt2_3"></td>
					<td style="width: 24mm;" id="ttt3_3"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">劳动力转移</td>

					<td style="width: 30mm;" id="ttt1_4"></td>
					<td style="width: 50mm;" id="ttt2_4"></td>
					<td style="width: 24mm;" id="ttt3_4"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">惠农补贴</td>

					<td style="width: 30mm;" id="ttt1_5"></td>
					<td style="width: 50mm;" id="ttt2_5"></td>
					<td style="width: 24mm;" id="ttt3_5"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">库区移民</td>

					<td style="width: 30mm;" id="ttt1_6"></td>
					<td style="width: 50mm;" id="ttt2_6"></td>
					<td style="width: 24mm;" id="ttt3_6"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">养老保险</td>

					<td style="width: 30mm;" id="ttt1_7"></td>
					<td style="width: 50mm;" id="ttt2_7"></td>
					<td style="width: 24mm;" id="ttt3_7"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">低保金</td>

					<td style="width: 30mm;" id="ttt1_8"></td>
					<td style="width: 50mm;" id="ttt2_8"></td>
					<td style="width: 24mm;" id="ttt3_8"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">生态补偿</td>

					<td style="width: 30mm;" id="ttt1_9"></td>
					<td style="width: 50mm;" id="ttt2_9"></td>
					<td style="width: 24mm;" id="ttt3_9"></td>
					<td style="width: 12mm;"></td>
				</tr>

				<tr>

					<td style="width: 12mm;font-size:14px">社会捐赠</td>

					<td style="width: 30mm;" id="ttt1_10"></td>
					<td style="width: 50mm;" id="ttt2_10"></td>
					<td style="width: 24mm;" id="ttt3_10"></td>
					<td style="width: 12mm;"></td>
				</tr>

			</tbody>
		</table>
		<p align='center'>帮扶成效</p>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>
					<td style="width: 12mm;">时间</td>
					<td style="width: 100mm;">成效内容</td>
					<td style="width: 20mm;">户主签名</td>
				</tr>

			</tbody>
		</table>
		<p align='center'>自我发展成效</p>
		<table cellpadding="0" cellspacing="0" border="0" class="tableStyle2">
			<tbody>
				<tr>
					<td style="width: 12mm;">时间</td>
					<td style="width: 100mm;">成效内容</td>
					<td style="width: 20mm;">户主签名</td>
				</tr>

			</tbody>
		</table>

</body>
</html>

<#-- 所有的自定义函数放在最下面 -->

<#-- 判断是否包含字符串, 注意大于小于等于的转义 -->
<#function isIndexOf v1 v2 v3 v4 >
	<#if v1?index_of(v2) gt -1 >
		<#return v3 >
	<#else>
		<#return v4 >
	</#if>
</#function>




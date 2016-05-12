<#include "./util.ftl">
[BELEGLISTE]
<#assign num = 0/>
<#list task.pous.* as pou> 
	<#if pou?node_name?matches("statein", 'i')>
ITEM_${num}=<@getAlAddr pou.INPUT.@address/><#assign num = num + 1/>
ITEM_${num}=<@getAlAddr pou.OUTPUT.@address/><#assign num = num + 1/>
	</#if>
</#list>

<#list task.pous.* as pou> 
	<#if pou?node_name?matches("statein", 'i')>
		<#assign name><@getVal pou.@name/></#assign>
[<@getAlAddr pou.INPUT.@address/>]
SYMBOL=${name}_in
COMMENT=${name} input komment
FORMAT=-1

[<@getAlAddr pou.OUTPUT.@address/>]
SYMBOL=${name}_out
COMMENT=${name} output komment
FORMAT=-1
	</#if>
</#list>

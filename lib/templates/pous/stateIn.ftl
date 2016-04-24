					<data name="http://www.3s-software.com/plcopenxml/pou" handleUnknown="implementation">
						<pou name="<@getVal pou.@name/>" pouType="program">
					    	<interface>
					        	<localVars>
					        		<variable name="input" address="%<@getVal pou.INPUT.@address/>">
					                	<type>
					                    	<BOOL />
										</type>
									</variable>
					                <variable name="output" address="%<@getVal pou.OUTPUT.@address/>">
					                	<type>
					                    	<BOOL />
										</type>
					            	</variable>
								</localVars>
							</interface>
					        <body>
					        	<ST>
									<xhtml xmlns="http://www.w3.org/1999/xhtml">
									output := input;
									</xhtml>
								</ST>
							</body>
						</pou>
					</data>

					<data name="http://www.3s-software.com/plcopenxml/pou" handleUnknown="implementation">
						<pou name="<@util.getVal pou.@name/>" pouType="program">
					    	<interface>
					        	<localVars>
					        		<variable name="input1" address="%<@util.getVal pou.INPUT.@address/>">
					                	<type>
					                    	<BOOL />
										</type>
									</variable>
					                <variable name="stop" address="%<@util.getVal pou.STOP.@address/>">
					                	<type>
					                    	<BOOL />
										</type>
					            	</variable>
					                <variable name="output" address="%<@util.getVal pou.OUTPUT.@address/>">
					                   	<type>
					                    	<BOOL />
					                 	</type>
					             	</variable>
								</localVars>
							</interface>
					        <body>
					        	<ST>
									<xhtml xmlns="http://www.w3.org/1999/xhtml">
									output := input1 OR output;
									IF
									 stop THEN output := FALSE;
									END_IF;
									</xhtml>
								</ST>
							</body>
						</pou>
					</data>

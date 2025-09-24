<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.TagEditor, App_Web_tageditor.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
	function ConfirmDelete() {
		return confirm('<%=_("Areyousure.Text")%>');
	}

	function openLocalizationPreloader() {
		let eds__ddlTranslateWithOpenAIOptions = eds3_5_jq('#<%=ddlTranslateWithOpenAIOptions.ClientID%>').val();
		if (eds__ddlTranslateWithOpenAIOptions != "liSelectedlanguage") {
			if (confirm("<%=AllLocalizationChangesWillBeLost%>") == true) {
			} else {
				return false;
			}
		}
		eds3_5_jq('#<%= pnlTagLocalization.ClientID%>').addClass('edNews_loading');

		return true;
	}

	eds3_5_jq(document).ready(function ($) {

		let teTitleTagCount = $('#<%=tbTagEditTitleTag.ClientID%>').val();
		if (teTitleTagCount)
			$('#edsNews__teTitleTagCount').text('(' + teTitleTagCount.length + ')');
		else
			$('#edsNews__teTitleTagCount').text('(0)');
		$('#<%=tbTagEditTitleTag.ClientID%>').keyup(function () {
			$('#edsNews__teTitleTagCount').text('(' + $(this).val().length + ')');
		});

		let teMetaDescriptionCount = $('#<%=tbTagEditMetaDescription.ClientID%>').val();
		if (teMetaDescriptionCount)
			$('#edsNews__teMetaDescriptionCount').text('(' + teMetaDescriptionCount.length + ')');
		else
			$('#edsNews__teMetaDescriptionCount').text('(0)');
		$('#<%=tbTagEditMetaDescription.ClientID%>').keyup(function () {
			$('#edsNews__teMetaDescriptionCount').text('(' + $(this).val().length + ')');
		});

		let teMetaMetaKeyWordsCount = $('#<%=tbTagEditMetaKeywords.ClientID%>').val();
		if (teMetaMetaKeyWordsCount)
			$('#edsNews__teMetaKeyWordsCount').text('(' + teMetaMetaKeyWordsCount.length + ')');
		else
			$('#edsNews__teMetaKeyWordsCount').text('(0)');
		$('#<%=tbTagEditMetaKeywords.ClientID%>').keyup(function () {
			$('#edsNews__teMetaKeyWordsCount').text('(' + $(this).val().length + ')');
		});

		let tlTitleTagCount = $('#<%=tbLocalizeTagEditTitleTag.ClientID%>').val();
		if (tlTitleTagCount)
			$('#edsNews__tlTitleTagCount').text('(' + tlTitleTagCount.length + ')');
		else
			$('#edsNews__tlTitleTagCount').text('(0)');
		$('#<%=tbLocalizeTagEditTitleTag.ClientID%>').keyup(function () {
			$('#edsNews__tlTitleTagCount').text('(' + $(this).val().length + ')');
		});

		let tlMetaDescriptionCount = $('#<%=tbLocalizeTagEditMetaDescription.ClientID%>').val();
		if (tlMetaDescriptionCount)
			$('#edsNews__tlMetaDescriptionCount').text('(' + tlMetaDescriptionCount.length + ')');
		else
			$('#edsNews__tlMetaDescriptionCount').text('(0)');
		$('#<%=tbLocalizeTagEditMetaDescription.ClientID%>').keyup(function () {
			$('#edsNews__tlMetaDescriptionCount').text('(' + $(this).val().length + ')');
		});

		let tlMetaKeywordsCount = $('#<%=tbLocalizeTagEditMetaKeywords.ClientID%>').val();
		if (tlMetaKeywordsCount)
			$('#edsNews__tlMetaKeyWordsCount').text('(' + tlMetaKeywordsCount.length + ')');
		else
			$('#edsNews__tlMetaKeyWordsCount').text('(0)');
		$('#<%=tbLocalizeTagEditMetaKeywords.ClientID%>').keyup(function () {
			$('#edsNews__tlMetaKeyWordsCount').text('(' + $(this).val().length + ')');
		});

	})

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {

			eds3_5_jq(document).ready(function ($) {

				eds3_5_jq('.edNews_tooltip').eds_tooltipster();

				let teTitleTagCount = $('#<%=tbTagEditTitleTag.ClientID%>').val();
				if (teTitleTagCount)
					$('#edsNews__teTitleTagCount').text('(' + teTitleTagCount.length + ')');
				else
					$('#edsNews__teTitleTagCount').text('(0)');
				$('#<%=tbTagEditTitleTag.ClientID%>').keyup(function () {
					$('#edsNews__teTitleTagCount').text('(' + $(this).val().length + ')');
				});

				let teMetaDescriptionCount = $('#<%=tbTagEditMetaDescription.ClientID%>').val();
				if (teMetaDescriptionCount)
					$('#edsNews__teMetaDescriptionCount').text('(' + teMetaDescriptionCount.length + ')');
				else
					$('#edsNews__teMetaDescriptionCount').text('(0)');
				$('#<%=tbTagEditMetaDescription.ClientID%>').keyup(function () {
					$('#edsNews__teMetaDescriptionCount').text('(' + $(this).val().length + ')');
				});

				let teMetaMetaKeyWordsCount = $('#<%=tbTagEditMetaKeywords.ClientID%>').val();
				if (teMetaMetaKeyWordsCount)
					$('#edsNews__teMetaKeyWordsCount').text('(' + teMetaMetaKeyWordsCount.length + ')');
				else
					$('#edsNews__teMetaKeyWordsCount').text('(0)');
				$('#<%=tbTagEditMetaKeywords.ClientID%>').keyup(function () {
					$('#edsNews__teMetaKeyWordsCount').text('(' + $(this).val().length + ')');
				});



				let tlTitleTagCount = $('#<%=tbLocalizeTagEditTitleTag.ClientID%>').val();
				if (tlTitleTagCount)
					$('#edsNews__tlTitleTagCount').text('(' + tlTitleTagCount.length + ')');
				else
					$('#edsNews__tlTitleTagCount').text('(0)');
				$('#<%=tbLocalizeTagEditTitleTag.ClientID%>').keyup(function () {
					$('#edsNews__tlTitleTagCount').text('(' + $(this).val().length + ')');
				});

				let tlMetaDescriptionCount = $('#<%=tbLocalizeTagEditMetaDescription.ClientID%>').val();
				if (tlMetaDescriptionCount)
					$('#edsNews__tlMetaDescriptionCount').text('(' + tlMetaDescriptionCount.length + ')');
				else
					$('#edsNews__tlMetaDescriptionCount').text('(0)');
				$('#<%=tbLocalizeTagEditMetaDescription.ClientID%>').keyup(function () {
					$('#edsNews__tlMetaDescriptionCount').text('(' + $(this).val().length + ')');
				});

				let tlMetaKeywordsCount = $('#<%=tbLocalizeTagEditMetaKeywords.ClientID%>').val();
				if (tlMetaKeywordsCount)
					$('#edsNews__tlMetaKeyWordsCount').text('(' + tlMetaKeywordsCount.length + ')');
				else
					$('#edsNews__tlMetaKeyWordsCount').text('(0)');
				$('#<%=tbLocalizeTagEditMetaKeywords.ClientID%>').keyup(function () {
					$('#edsNews__tlMetaKeyWordsCount').text('(' + $(this).val().length + ')');
				});
			})

		}
	}

</script>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=_("TagEditor")%></span>
		</div>
		<asp:UpdatePanel ID="upMainAjax" runat="server" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<div class="edNews_adminProgressOverlayWrapper">
					<asp:UpdateProgress ID="uppMainAjax" runat="server" AssociatedUpdatePanelID="upMainAjax" DisplayAfter="100" DynamicLayout="true">
						<ProgressTemplate>
							<div class="edNews_adminProgressOverlay"></div>
						</ProgressTemplate>
					</asp:UpdateProgress>
					<asp:Panel ID="pnlTagsGridView" runat="server" Visible="true" CssClass="sectionBox noPadding">
						<asp:GridView ID="gvTags" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" DataSourceID="odsTags" CssClass="strippedTable fullWidthTable noBorder tablePadding5 textCenter" DataKeyNames="TagID" OnRowCommand="gvTags_RowCommand" AllowPaging="True" OnPageIndexChanging="gvTags_PageIndexChanging" OnRowUpdating="gvTags_RowUpdating">
							<Columns>
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<div class="edNews_boxedActions">
											<asp:LinkButton ID="lbEdiTag" runat="server" CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("LinkButton1Resource1.Text")%>' CommandArgument='<%# Eval("TagID") %>' data-tooltip-position="top-left" CausesValidation="False" CommandName="EditTag" resourcekey="LinkButton1Resource1" Text="Edit" />
											<asp:LinkButton ID="LinkButton2" runat="server" CssClass="edNews_aaDelete color4 edNews_tooltip" data-tooltip-content='<%#_("LinkButton2Resource1.Text")%>' data-tooltip-position="top-left" CausesValidation="False" CommandName="Delete" resourcekey="LinkButton2Resource1" Text="Delete" OnClientClick="return ConfirmDelete();" />
											<asp:LinkButton ID="lbLocalizeimage" runat="server" CssClass="edNews_aaLocalization color2 edNews_tooltip" data-tooltip-content='<%#_("lbLocalizeimage.Text")%>' data-tooltip-position="top-left" CommandArgument='<%# Eval("TagID") %>' resourcekey="lbLocalizeimage" CommandName="Localize" Visible='<%#EnableLocalization%>' Text="Localize" />
										</div>
									</ItemTemplate>
									<ItemStyle Width="100px" CssClass="textLeft" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Tag" SortExpression="Name">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
										<asp:CheckBox CssClass="normalCheckBox" ID="cbMergeTag" runat="server" Checked='False' />
										<asp:Label ID="lblTagRenameHelp" resourcekey="lblTagRenameHelp" runat="server" Text='Merge tag with another tag.'></asp:Label>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Number of articles" SortExpression="CountNumber">
									<ItemTemplate>
										<asp:Label ID="lblCountNumber" runat="server" Text='<%# Bind("CountNumber") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Localized">
									<ItemTemplate>
										<asp:Label ID="lblLocalizedList" runat="server" Text='<%# Bind("Localized") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
							<EditRowStyle CssClass="editItemState" />
							<HeaderStyle CssClass="tableHeader" />
							<PagerStyle CssClass="contentPagination" />
						</asp:GridView>
						<asp:Label ID="lblMainEditMessage" runat="server" EnableViewState="false" />
						<div class="edNews_numberOfRows">
							<div>
								<asp:Label ID="lblSortingMethod" runat="server" AssociatedControlID="ddlSortingMethod" resourcekey="lblSortingMethod" Text="Order by:"></asp:Label>
								<asp:DropDownList ID="ddlSortingMethod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddllSortingMethod_SelectedIndexChanged">
									<asp:ListItem resourcekey="liNameAscending" Value="1">Name ASC</asp:ListItem>
									<asp:ListItem resourcekey="liNameDescending" Value="2">Name DSC</asp:ListItem>
									<asp:ListItem resourcekey="liDateAscending" Value="3">Date ASC</asp:ListItem>
									<asp:ListItem resourcekey="liDateDescending" Value="4">Date DSC</asp:ListItem>
								</asp:DropDownList>
							</div>
							<div>
								<asp:Label ID="lblFooterSelectNumberOfRows" runat="server" AssociatedControlID="ddlFooterNumberOfRows" resourcekey="lblFooterSelectNumberOfRowsResource1" Text="Number of rows:"></asp:Label>
								<asp:DropDownList ID="ddlFooterNumberOfRows" runat="server" AutoPostBack="True" resourcekey="ddlFooterNumberOfRowsResource1" OnSelectedIndexChanged="ddlFooterNumberOfRows_SelectedIndexChanged">
									<asp:ListItem resourcekey="ListItemResource40" Value="10">10</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource41" Value="20">20</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource42" Value="30">30</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource43" Value="50">50</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource44" Value="100">100</asp:ListItem>
								</asp:DropDownList>
							</div>
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlTagLocalization" CssClass="topMargin" runat="server" Visible="false">
						<asp:HiddenField ID="hfTagID" runat="server" />
						<table class="optionsList strippedTable fullWidthTable noBorder">
							<tr>
								<td class="tdLabel">
									<asp:Label ID="lblContentLocalizationMediaTitle" resourcekey="lblContentLocalizationMediaTitle" runat="server" Font-Bold="True" Text="Tag:" />
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationMediaTitleOriginal" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<asp:Label ID="lblPortalDefLanguage" runat="server" Text="Poratal default language:" resourcekey="lblPortalDefLanguageResource1" />
								</td>
								<td>
									<asp:Label ID="lblDefaultPortalLangugageImage" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<asp:Label ID="lblContentLocalizationLocalizedLanguages" runat="server" Text="Localized languages:" resourcekey="lblContentLocalizationLocalizedLanguages" />
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationLocalizedLanguagesList" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlContentLocalizationSelectLanguage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationSelectLanguage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationSelectLanguage.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlContentLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlContentLocalizationSelectLanguage_SelectedIndexChanged" />
									<div class="mainActions smallActions displayInline noMargin">
										<asp:LinkButton ID="btnContentLocalizationCopyDefault" resourcekey="btnContentLocalizationCopyDefault" CssClass="copy" runat="server" OnClick="btnContentLocalizationCopyDefault_Click">Copy default values</asp:LinkButton>
										<asp:LinkButton ID="btnDeleteLocalization" resourcekey="btnDeleteLocalization" CssClass="delete" runat="server" OnClick="btnDeleteLocalization_Click" OnClientClick="return ConfirmDelete();">Delete selected tag locale</asp:LinkButton>
									</div>
								</td>
							</tr>
							<tr runat="server" id="aiTranslateOptionsRow" visible="false">
								<td class="tdLabel">
									<label for="<%=ddlTranslateWithOpenAIOptions.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("AItranslateOptions.Help", true) %>" data-tooltip-position="top-right"><%=_("AItranslateOptions.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTranslateWithOpenAIOptions" runat="server" Visible="false">
										<asp:ListItem resourcekey="liAllLanguages" Value="liAllLanguages" Text="All languages" />
										<asp:ListItem resourcekey="liSelectedlanguage" Value="liSelectedlanguage" Text="Selected language" />
										<asp:ListItem resourcekey="liOnlylanguagesWithoutTranslation" Value="liWithoutTranslation" Text="Only languages without translation" />
									</asp:DropDownList>
									<div class="mainActions smallActions noMargin displayInline">
										<asp:LinkButton ID="lbTranslateWithOpenAI" OnClientClick="return openLocalizationPreloader();" runat="server" CssClass="primaryAction" OnClick="lbTranslateWithOpenAI_Click" resourcekey="lbTranslateWithAI" Text="Translate with Open AI" Visible="False" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxLocalizedTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationTitle.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbxLocalizedTag" runat="server" CssClass="text s18" Width="400px" MaxLength="50" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLocalizeTagEditDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditDescription.Text") %></label>
								</td>
								<td>
									<dnn:TextEditor ID="tbLocalizeTagEditDescription" runat="server" Height="300" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLocalizeTagEditTitleTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditTitleTag.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditTitleTag.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbLocalizeTagEditTitleTag" runat="server" CssClass="text s18" Width="600px" />
									<label class="textLeft labelInline edNews_tooltip" id="edsNews__tlTitleTagCount" for="<%=tbLocalizeTagEditTitleTag.ClientID %>" data-tooltip-content="<%=_("TitleTagCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLocalizeTagEditMetaDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditMetaDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditMetaDescription.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbLocalizeTagEditMetaDescription" runat="server" CssClass="text s18" Width="600px" />
									<label class="textLeft labelInline edNews_tooltip" id="edsNews__tlMetaDescriptionCount" for="<%=tbLocalizeTagEditMetaDescription.ClientID %>" data-tooltip-content="<%=_("MetaDescriptionCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLocalizeTagEditMetaKeywords.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditMetaKeywords.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditMetaKeywords.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbLocalizeTagEditMetaKeywords" runat="server" CssClass="text s18" Width="600px" />
									<label class="textLeft labelInline edNews_tooltip" id="edsNews__tlMetaKeyWordsCount" for="<%=tbLocalizeTagEditMetaKeywords.ClientID %>" data-tooltip-content="<%=_("MetaKeywordsCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlLocalizeTagEditAddRobotsFollowTagUpdate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditAddRobotsFollowTag.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditAddRobotsFollowTag.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlLocalizeTagEditAddRobotsFollowTagUpdate" runat="server">
										<asp:ListItem resourcekey="liDefault" Value="-1">Default</asp:ListItem>
										<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
										<asp:ListItem>INDEX, NOFOLLOW</asp:ListItem>
										<asp:ListItem>NOINDEX, FOLLOW</asp:ListItem>
										<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
						</table>
						<div class="mainActions">
							<asp:LinkButton ID="btnContentLocalizationUpdate" resourcekey="btnContentLocalizationUpdate" CssClass="downSave" runat="server" OnClick="btnContentLocalizationUpdate_Click">Save/Update localization</asp:LinkButton>
							<asp:LinkButton ID="btnContentLocalizationClose" resourcekey="btnContentLocalizationClose" CssClass="cancel" runat="server" OnClick="btnContentLocalizationClose_Click">Close</asp:LinkButton>
						</div>
						<asp:Label ID="lblErrorInfoMsg" runat="server" EnableViewState="false" Visible="false" />
					</asp:Panel>
					<asp:Panel ID="pnlEditTag" CssClass="topMargin" runat="server" Visible="false">
						<asp:HiddenField ID="hfEditTagID" runat="server" />
						<table class="optionsList strippedTable fullWidthTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTagNametoEdit.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagNametoEditHelp.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagNametoEditHelp.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTagNametoEdit" runat="server" CssClass="text s18" MaxLength="50" Width="400px" />
									<asp:RequiredFieldValidator ID="rfvTagName" CssClass="smallInfo error" runat="server" ControlToValidate="tbTagNametoEdit" ErrorMessage="Please enter a name." ValidationGroup="vgTagEdit" resourcekey="rfvTagName.ErrorMessage" SetFocusOnError="True" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbTagEditMergeTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditMergeTag.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditMergeTag.Text") %></label>
								</td>
								<td>
									<asp:CheckBox CssClass="normalCheckBox" ID="cbTagEditMergeTag" runat="server" Checked='False' />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=txtTagEditDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditDescription.Text") %></label>
								</td>
								<td>
									<dnn:TextEditor ID="txtTagEditDescription" runat="server" Height="300" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=fuTagImage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagImage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagImage.Text") %></label>
								</td>
								<td>
									<asp:Image ID="imageTagEditImage" CssClass="edNews_thumb" runat="server" />
									<asp:FileUpload ID="fuTagImage" CssClass="image_selector" runat="server" />
									<asp:Panel ID="pnlTagEditDeleteImage" CssClass="edNews_inputGroup edNews_removeImage clearFix" runat="server">
										<div class="mainActions noMargin smallActions floatRight">
											<asp:LinkButton ID="lbTagEditRemoveImage" CssClass="delete" runat="server" OnClick="lbTagEditRemoveImage_Click" resourcekey="lbTagEditRemoveImage">Delete</asp:LinkButton>
										</div>
										<p><strong>This image</strong> is selected as the tag's image</p>
									</asp:Panel>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTagEditTitleTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditTitleTag.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditTitleTag.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTagEditTitleTag" runat="server" CssClass="text s18" Width="600px" />
									<label class="textLeft labelInline edNews_tooltip" id="edsNews__teTitleTagCount" for="<%=tbTagEditTitleTag.ClientID %>" data-tooltip-content="<%=_("TitleTagCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTagEditMetaDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditMetaDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditMetaDescription.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTagEditMetaDescription" runat="server" CssClass="text s18" Width="600px" />
									<label class="textLeft labelInline edNews_tooltip" id="edsNews__teMetaDescriptionCount" for="<%=tbTagEditMetaDescription.ClientID %>" data-tooltip-content="<%=_("MetaDescriptionCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTagEditMetaKeywords.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditMetaKeywords.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditMetaKeywords.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTagEditMetaKeywords" runat="server" CssClass="text" Width="600px" />
									<label class="textLeft labelInline edNews_tooltip" id="edsNews__teMetaKeyWordsCount" for="<%=tbTagEditMetaKeywords.ClientID %>" data-tooltip-content="<%=_("MetaKeywordsCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlTagEditAddRobotsFollowTagUpdate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagEditAddRobotsFollowTag.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagEditAddRobotsFollowTag.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTagEditAddRobotsFollowTagUpdate" runat="server">
										<asp:ListItem resourcekey="liDefault" Value="-1">Default</asp:ListItem>
										<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
										<asp:ListItem>INDEX, NOFOLLOW</asp:ListItem>
										<asp:ListItem>NOINDEX, FOLLOW</asp:ListItem>
										<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
						</table>
						<div class="mainActions">
							<asp:LinkButton ID="lbUpdateSaveTagEdit" resourcekey="lbUpdateSaveTagEdit" CssClass="downSave" runat="server" OnClick="lbUpdateSaveTagEdit_Click" ValidationGroup="vgTagEdit">Save/Update</asp:LinkButton>
							<asp:LinkButton ID="lbCloseTagEdit" resourcekey="lbCloseTagEdit" CssClass="cancel" runat="server" OnClick="lbCloseTagEdit_Click">Close</asp:LinkButton>
						</div>
						<asp:Label ID="lblTagEditMessage" runat="server" EnableViewState="false" Visible="false" />
					</asp:Panel>
				</div>
			</ContentTemplate>
			<Triggers>
				<asp:PostBackTrigger ControlID="lbUpdateSaveTagEdit" />
			</Triggers>
		</asp:UpdatePanel>
	</div>
</div>
<asp:ObjectDataSource ID="odsTags" runat="server" SelectMethod="GetAllNewTags" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdateNewTagName" DeleteMethod="DeleteNewTag" EnablePaging="True" SelectCountMethod="GetAllNewTagsTotalTags" OnUpdated="odsTags_Updated">
	<DeleteParameters>
		<asp:Parameter Name="TagID" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="maximumRows" Type="Int32" />
		<asp:Parameter Name="startRowIndex" Type="Int32" />
		<asp:ControlParameter ControlID="ddlSortingMethod" DefaultValue="1" Name="sortMethod" Type="String" PropertyName="SelectedValue" />
	</SelectParameters>
	<UpdateParameters>
		<asp:Parameter Name="TagID" Type="Int32" />
		<asp:Parameter Name="Name" Type="String" />
		<asp:Parameter Name="CountNumber" Type="Int32" />
		<asp:Parameter Name="Localized" Type="String" />
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="meregeTags" Type="Boolean" />
	</UpdateParameters>
</asp:ObjectDataSource>

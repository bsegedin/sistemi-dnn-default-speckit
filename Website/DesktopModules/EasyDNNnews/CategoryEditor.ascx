<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.CategoryEditor, App_Web_categoryeditor.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register Src="~/controls/URLControl.ascx" TagName="URL" TagPrefix="Portal" %>
<script type="text/javascript">
	function ShowValue() {
		return confirm('<%=Localization.GetString("Areyousure.Text", this.LocalResourceFile)%>');
	}

	function openLocalizationPreloader() {
		let eds__ddlTranslateWithOpenAIOptions = eds3_5_jq('#<%=ddlTranslateWithOpenAIOptions.ClientID%>').val();
		if (eds__ddlTranslateWithOpenAIOptions != "liSelectedlanguage") {
			if (confirm("<%=AllLocalizationChangesWillBeLost%>") == true) {
			} else {
				return false;
			}
		}
		eds3_5_jq('#<%= pnlCategoryLocalization.ClientID%>').addClass('edNews_loading');
		return true;
	}

	eds3_5_jq(function ($) {

		$(document).ready(function () {

			let ceTitleTagCount = $('#<%=tbTitleTag.ClientID%>').val();
			if (ceTitleTagCount)
				$('#edsNews__ceTitleTagCount').text('(' + ceTitleTagCount.length + ')');
			else
				$('#edsNews__ceTitleTagCount').text('(0)');

			let ceMetaDescriptionCount = $('#<%=tbMetaDecription.ClientID%>').val();
			if (ceMetaDescriptionCount)
				$('#edsNews__ceMetaDescriptionCount').text('(' + ceMetaDescriptionCount.length + ')');
			else
				$('#edsNews__ceMetaDescriptionCount').text('(0)');

			let ceMetaKeywordsCount = $('#<%=tbMetaKeywords.ClientID%>').val();
			if (ceMetaKeywordsCount)
				$('#edsNews__ceMetaKeywordsCount').text('(' + ceMetaKeywordsCount.length + ')');
			else
				$('#edsNews__ceMetaKeywordsCount').text('(0)');


			let ceTitleUpdateCount = $('#<%=tbTitleTagUpdate.ClientID%>').val();
			if (ceTitleUpdateCount)
				$('#edsNews__ceTitleTagUpdateCount').text('(' + ceTitleUpdateCount.length + ')');
			else
				$('#edsNews__ceTitleTagUpdateCount').text('(0)');

			let ceMetaDescriptionUpdateCount = $('#<%=tbMetaDecriptionUpdate.ClientID%>').val();
			if (ceMetaDescriptionUpdateCount)
				$('#edsNews__ceMetaDecriptionUpdateCount').text('(' + ceMetaDescriptionUpdateCount.length + ')');
			else
				$('#edsNews__ceMetaDecriptionUpdateCount').text('(0)');

			let ceMetaKeywordsUpdateCount = $('#<%=tbMetaKeywordsUpdate.ClientID%>').val();
			if (ceMetaKeywordsUpdateCount)
				$('#edsNews__ceMetaKeywordsUpdateCount').text('(' + ceMetaKeywordsUpdateCount.length + ')');
			else
				$('#edsNews__ceMetaKeywordsUpdateCount').text('(0)');

			let ceTitleLozalizationCount = $('#<%=tbTitleTagLocalization.ClientID%>').val();
			if (ceTitleLozalizationCount)
				$('#edsNews__ceTitleTagLozalizationCount').text('(' + ceTitleLozalizationCount.length + ')');
			else
				$('#edsNews__ceTitleTagLozalizationCount').text('(0)')

			let ceMetaDecriptionLozalizationCount = $('#<%=tbMetaDecriptionLocalization.ClientID%>').val();
			if (ceMetaDecriptionLozalizationCount)
				$('#edsNews__ceMetaDecriptionLocalizationCount').text('(' + ceMetaDecriptionLozalizationCount.length + ')');
			else
				$('#edsNews__ceMetaDecriptionLocalizationCount').text('(0)')

			let ceMetaKeywordsLozalizationCount = $('#<%=tbMetaKeywordsLocalization.ClientID%>').val();
			if (ceMetaKeywordsLozalizationCount)
				$('#edsNews__ceMetaKeywordsLocalizationCount').text('(' + ceMetaKeywordsLozalizationCount.length + ')');
			else
				$('#edsNews__ceMetaKeywordsLocalizationCount').text('(0)')


			$('#<%=tbQueryLink.ClientID%>').EDNGenerateUrl('#<%=tbQueryLinkGenerated.ClientID%>', {
				<%=jsReplaceCharacters%>
			});

			$('#<%=tbQueryLinkUpdate.ClientID%>').EDNGenerateUrl('#<%=tbQueryLinkUpdatePreview.ClientID%>', {
				<%=jsReplaceCharacters%>
			});

			$('#<%=tbQueryLinkLocalization.ClientID%>').EDNGenerateUrl('#<%=tbQueryLinkLocalizationPreview.ClientID%>', {
				<%=jsReplaceCharacters%>
			});

			$('#<%=tbTitleTag.ClientID%>').keyup(function () {
				$('#edsNews__ceTitleTagCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbMetaDecription.ClientID%>').keyup(function () {
				$('#edsNews__ceMetaDescriptionCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbMetaKeywords.ClientID%>').keyup(function () {
				$('#edsNews__ceMetaKeywordsCount').text('(' + $(this).val().length + ')');
			});


			$('#<%=tbTitleTagUpdate.ClientID%>').keyup(function () {
				$('#edsNews__ceTitleTagUpdateCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbMetaDecriptionUpdate.ClientID%>').keyup(function () {
				$('#edsNews__ceMetaDecriptionUpdateCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbMetaKeywordsUpdate.ClientID%>').keyup(function () {
				$('#edsNews__ceMetaKeywordsUpdateCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbTitleTagLocalization.ClientID%>').keyup(function () {
				$('#edsNews__ceTitleTagLozalizationCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbMetaDecriptionLocalization.ClientID%>').keyup(function () {
				$('#edsNews__ceMetaDecriptionLocalizationCount').text('(' + $(this).val().length + ')');
			});

			$('#<%=tbMetaKeywordsLocalization.ClientID%>').keyup(function () {
				$('#edsNews__ceMetaKeywordsLocalizationCount').text('(' + $(this).val().length + ')');
			});


			$('#<%=tbQueryLink.ClientID%>').trigger('keyup');

			$('#<%=tbQueryLinkUpdate.ClientID%>').trigger('keyup');

			$('#<%=tbQueryLinkLocalization.ClientID%>').trigger('keyup');

		});

	})
</script>
<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topActions">
			<li class="edNews_close">
				<asp:LinkButton ID="hlPowerOff" runat="server" OnClick="lbClose_Click" resourcekey="lbCloseResource1"></asp:LinkButton>
			</li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=CategoryManager%></span>
		</div>
		<asp:Panel ID="pnlCatManagment" CssClass="sectionBox noPadding" runat="server">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=Categories%></span>
			</div>
			<div class="sectionBox noPadding sectionBox">
				<div class="edNews_twoColumns edNews_twoColumns_7030 noBorder edNews_highLightedRight">
					<div>
						<asp:ListBox ID="lbCategoryList" runat="server" CssClass="edNews_listBox" />
					</div>
					<div>
						<div class="sectionBox sectionBox3 noPadding noMargin noBorder">
							<div class="sectionBoxHeader">
								<span class="sectionBoxHeaderTitle">Position</span>
							</div>
							<div class="edNews_MoveActions">
								<div>
									<asp:LinkButton ID="ibUP" runat="server" CssClass="edNews_moveUp" OnCommand="CategoryPositioning" CommandName="Up" resourcekey="ibUP" />
								</div>
								<asp:LinkButton ID="ibLeft" runat="server" CssClass="edNews_moveLeft" OnCommand="CategoryPositioning" CommandName="Left" resourcekey="ibLeft" />
								<asp:LinkButton ID="ibDown" runat="server" CssClass="edNews_moveDown" OnCommand="CategoryPositioning" CommandName="Down" resourcekey="ibDown" />
								<asp:LinkButton ID="inRight" runat="server" CssClass="edNews_moveRight" OnCommand="CategoryPositioning" CommandName="Right" resourcekey="inRight" />
							</div>
						</div>
						<div class="sectionBox sectionBox3 noPadding noMargin noBorder">
							<div class="sectionBoxHeader">
								<span class="sectionBoxHeaderTitle">Edit/Remove</span>
							</div>
							<div class="edNews_editRemoveActions">
								<asp:LinkButton ID="inEditItem" runat="server" CssClass="edNews_edit" OnClick="inEditItem_Click" resourcekey="inEditItem" />
								<asp:LinkButton ID="ibDelete" runat="server" CssClass="edNews_delete" OnClientClick="return ShowValue();" OnClick="ibDelete_Click" resourcekey="ibDelete" />
								<asp:Label ID="lblDeleteMessage" CssClass="infoMessages success" runat="server" EnableViewState="false" Visible="false" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlAddCategories" CssClass="sectionBox" runat="server">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=AddCategory%></span>
			</div>
			<div class="edNews_inputGroup inputWidth40">
				<label class="textLeft" for="<%=tbCategoryName.ClientID %>"><%=Categoryname %></label>
				<asp:TextBox ID="tbCategoryName" runat="server" MaxLength="100" ValidationGroup="vgCreateCat" />
				<asp:RequiredFieldValidator ID="rfvCatName" CssClass="smallInfo error" runat="server" ControlToValidate="tbCategoryName" ErrorMessage="Please enter a name." ValidationGroup="vgCreateCat" resourcekey="rfvCatNameResource1" SetFocusOnError="True" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlParentCategoryList.ClientID%>"><%=Categoryparent%></label>
				<asp:DropDownList ID="ddlParentCategoryList" runat="server" AppendDataBoundItems="True" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlCategoryColor.ClientID%>"><%=CategoryColor%></label>
				<asp:DropDownList ID="ddlCategoryColor" runat="server" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=txtCatText.ClientID %>"><%=Categorydescription%></label>
				<dnn:TextEditor ID="txtCatText" runat="server" Height="300" />
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categoryimage %></span>
				</div>
				<div class="edNews_inputGroup">
					<asp:FileUpload ID="fuCatImage" CssClass="image_selector" runat="server" />
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categorylink%></span>
				</div>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblSelectUrlAdd" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSelectUrlAdd_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Selected="True" Value="None" Text="None" resourcekey="ListItemResource2" />
						<asp:ListItem Value="URL" Text="Link" resourcekey="ListItemResource3" />
						<asp:ListItem Value="Page" Text="Page in the site" resourcekey="ListItemResource4" />
					</asp:RadioButtonList>
				</div>
				<div class="edNews_inputGroup inputWidth100">
					<asp:TextBox ID="tbCatURLAdd" runat="server" Visible="false" resourcekey="tbCatURLAddResource1"></asp:TextBox>
					<Portal:URL ID="ctlURLAdd" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" ShowTabs="true" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U" Visible="false" />
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=SEOOptions%></span>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbQueryLink.ClientID %>" data-tooltip-content="<%=_("CategoryURL.Help", true) %>" data-tooltip-position="top-right"><%=_("CategoryURL.Text") %></label>
					<asp:TextBox ID="tbQueryLink" runat="server" MaxLength="800" ValidationGroup="vgCreateCat" />
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbQueryLinkGenerated.ClientID %>" data-tooltip-content="<%=_("CategoryURLPreview.Help", true) %>" data-tooltip-position="top-right"><%=_("CategoryURLPreview.Text") %></label>
					<asp:TextBox ID="tbQueryLinkGenerated" runat="server" MaxLength="800" ValidationGroup="vgCreateCat" Enabled="False" />
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbTitleTag.ClientID %>" data-tooltip-content="<%=_("TitleTag.Help", true) %>" data-tooltip-position="top-right"><%=_("TitleTag.Text") %></label>
					<asp:TextBox ID="tbTitleTag" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceTitleTagCount" for="<%=tbTitleTag.ClientID %>" data-tooltip-content="<%=_("TitleTagCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbMetaDecription.ClientID %>" data-tooltip-content="<%=_("MetaDecription.Help", true) %>" data-tooltip-position="top-right"><%=_("MetaDecription.Text") %></label>
					<asp:TextBox ID="tbMetaDecription" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceMetaDescriptionCount" for="<%=tbMetaDecription.ClientID %>" data-tooltip-content="<%=_("MetaDescriptionCharacterCount.Help", true) %>" data-tooltip-position="top-right"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbMetaKeywords.ClientID %>" data-tooltip-content="<%=_("MetaKeywords.Help", true) %>" data-tooltip-position="top-right"><%=_("MetaKeywords.Text") %></label>
					<asp:TextBox ID="tbMetaKeywords" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceMetaKeywordsCount" for="<%=tbMetaKeywords.ClientID %>" data-tooltip-content="<%=_("MetaKeyWordsCharacterCount.Help", true) %>" data-tooltip-position="top-right"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=ddlAddRobotsFollowTag.ClientID %>" data-tooltip-content="<%=_("AddRobotsFollowTag.Help", true) %>" data-tooltip-position="top-right"><%=_("AddRobotsFollowTag.Text") %></label>
					<asp:DropDownList ID="ddlAddRobotsFollowTag" runat="server">
						<asp:ListItem Value="-1">None</asp:ListItem>
						<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
						<asp:ListItem>INDEX, NOFOLLOW</asp:ListItem>
						<asp:ListItem>NOINDEX, FOLLOW</asp:ListItem>
						<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
					</asp:DropDownList>
				</div>
			</div>
			<asp:Label ID="lblCreateCatMessage" runat="server" EnableViewState="false" />
			<div class="mainActions">
				<asp:LinkButton ID="lbAddNewCategory" runat="server" CssClass="add" OnClick="lbAddNewCategory_Click" ValidationGroup="vgCreateCat" resourcekey="lbAddNewCategoryResource1">Add new category</asp:LinkButton>
				<asp:LinkButton ID="lbClose" runat="server" CssClass="cancel" OnClick="lbClose_Click" resourcekey="lbCloseResource1">Close</asp:LinkButton>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlEditCatItem" CssClass="sectionBox" runat="server" Visible="False">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=EditCategory%></span>
				<div class="mainActions floatRight noMargin smallActions">
					<asp:LinkButton ID="lbLocalizeContent" runat="server" OnClick="lbLocalizeContent_Click" CssClass="primaryAction" resourcekey="lbLocalizeContentResource1" Visible="false">Category localization</asp:LinkButton>
				</div>
			</div>
			<div class="edNews_inputGroup inputWidth40">
				<label class="textLeft" for="<%=tbCategoryName.ClientID %>"><%=Categoryname%></label>
				<asp:TextBox ID="tbCategoryTitleUpdate" runat="server" MaxLength="100" ValidationGroup="vgCatTitleUpdate" CausesValidation="true" />
				<asp:RequiredFieldValidator ID="rfvCategoryName" CssClass="smallInfo error" runat="server" ControlToValidate="tbCategoryTitleUpdate" ErrorMessage="This field is required." ValidationGroup="vgCatTitleUpdate" resourcekey="rfvCategoryNameResource1" SetFocusOnError="True" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlParentCategoryEditList.ClientID%>"><%=Categoryparent%></label>
				<asp:DropDownList ID="ddlParentCategoryEditList" runat="server" AppendDataBoundItems="True" resourcekey="ddlParentCategoryEditListResource1">
					<asp:ListItem Value="-1" resourcekey="ListItemResource5">Select parent category</asp:ListItem>
					<asp:ListItem Value="0" resourcekey="ListItemResource6">No parent category</asp:ListItem>
				</asp:DropDownList>
				<asp:RadioButtonList ID="rblCategoriesMove" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCategoriesMove_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
					<asp:ListItem resourcekey="liMoveAllCategories" Selected="True" Value="all">Move category with subcategories</asp:ListItem>
					<asp:ListItem resourcekey="liMoveOneCategory" Value="one">Move only one category</asp:ListItem>
				</asp:RadioButtonList>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlCategoryColorEdit.ClientID%>"><%=CategoryColor%></label>
				<asp:DropDownList ID="ddlCategoryColorEdit" runat="server" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=txtCatText.ClientID %>"><%=Categorydescription%></label>
				<dnn:TextEditor ID="txtCatDescriptionEdit" runat="server" Height="300" />
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categoryimage%></span>
				</div>
				<div class="edNews_imagePanel clearFix">
					<asp:Image ID="imgCatImageUpdate" CssClass="edNews_thumb" runat="server" />
					<div class="edNews_inputGroup displayInline edNews_fileUpload">
						<asp:FileUpload ID="fuCatReplaceImage" runat="server" />
					</div>
					<asp:Panel ID="pnlDeleteImage" CssClass="edNews_inputGroup edNews_removeImage clearFix" runat="server">
						<div class="mainActions noMargin smallActions floatRight">
							<asp:LinkButton ID="lbRemoveImage" CssClass="delete" runat="server" OnClick="lbRemoveImage_Click" resourcekey="lbRemoveImageResource1">Delete</asp:LinkButton>
						</div>
						<p><strong>This image</strong> is selected as the category's image</p>
					</asp:Panel>
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categorylink%></span>
				</div>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblSelectUrl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSelectUrl_SelectedIndexChanged" resourcekey="rblSelectUrlResource1" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Value="None" Selected="True" resourcekey="ListItemResource7">None</asp:ListItem>
						<asp:ListItem Value="URL" resourcekey="ListItemResource8">Link</asp:ListItem>
						<asp:ListItem Value="Page" resourcekey="ListItemResource9">Page in the site</asp:ListItem>
					</asp:RadioButtonList>
				</div>
				<div class="edNews_inputGroup inputWidth100">
					<asp:TextBox ID="tbCatURL" runat="server"></asp:TextBox>
					<Portal:URL ID="ctlURL" runat="server" ShowNewWindow="False" ShowUsers="False" ShowFiles="False" ShowLog="False" ShowSecure="False" ShowTabs="True" ShowTrack="False" ShowUpLoad="False" ShowUrls="False" ShowDatabase="False" UrlType="U" />
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=SEOOptions%></span>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbQueryLinkUpdate.ClientID %>" data-tooltip-content="<%=_("CategoryURL.Help", true) %>" data-tooltip-position="top-right"><%=_("CategoryURL.Text") %></label>
					<asp:TextBox ID="tbQueryLinkUpdate" runat="server" MaxLength="800" ValidationGroup="vgCreateCat" />
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbQueryLinkUpdatePreview.ClientID %>" data-tooltip-content="<%=_("CategoryURLPreview.Help", true) %>" data-tooltip-position="top-right"><%=_("CategoryURLPreview.Text") %></label>
					<asp:TextBox ID="tbQueryLinkUpdatePreview" runat="server" MaxLength="800" ValidationGroup="vgCreateCat" Enabled="False" />
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbTitleTagUpdate.ClientID %>" data-tooltip-content="<%=_("TitleTag.Help", true) %>" data-tooltip-position="top-right"><%=_("TitleTag.Text") %></label>
					<asp:TextBox ID="tbTitleTagUpdate" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceTitleTagUpdateCount" for="<%=tbTitleTagUpdate.ClientID %>" data-tooltip-content="<%=_("TitleTagCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbMetaDecriptionUpdate.ClientID %>" data-tooltip-content="<%=_("MetaDecription.Help", true) %>" data-tooltip-position="top-right"><%=_("MetaDecription.Text") %></label>
					<asp:TextBox ID="tbMetaDecriptionUpdate" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceMetaDecriptionUpdateCount" for="<%=tbMetaDecriptionUpdate.ClientID %>" data-tooltip-content="<%=_("MetaDescriptionCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbMetaKeywordsUpdate.ClientID %>" data-tooltip-content="<%=_("MetaKeywords.Help", true) %>" data-tooltip-position="top-right"><%=_("MetaKeywords.Text") %></label>
					<asp:TextBox ID="tbMetaKeywordsUpdate" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceMetaKeywordsUpdateCount" for="<%=tbMetaKeywordsUpdate.ClientID %>" data-tooltip-content="<%=_("MetaKeyWordsCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=ddlAddRobotsFollowTagUpdate.ClientID %>" data-tooltip-content="<%=_("AddRobotsFollowTag.Help", true) %>" data-tooltip-position="top-right"><%=_("AddRobotsFollowTag.Text") %></label>
					<asp:DropDownList ID="ddlAddRobotsFollowTagUpdate" runat="server">
						<asp:ListItem Value="-1">None</asp:ListItem>
						<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
						<asp:ListItem>INDEX, NOFOLLOW</asp:ListItem>
						<asp:ListItem>NOINDEX, FOLLOW</asp:ListItem>
						<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
					</asp:DropDownList>
				</div>
			</div>
			<asp:Label ID="lblUpdateCategoryMessage" runat="server" EnableViewState="false" Visible="False" />
			<div class="mainActions">
				<asp:LinkButton ID="lbUpdateCategory" runat="server" CssClass="downSave" OnClick="lbUpdateCategory_Click" ValidationGroup="vgCatTitleUpdate" CausesValidation="true" resourcekey="lbUpdateCategoryResource1">Update category</asp:LinkButton>
				<asp:LinkButton ID="lbCancel" runat="server" OnClick="lbCancel_Click" CssClass="cancel" resourcekey="lbCancelResource1">Cancel</asp:LinkButton>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlCategoryLocalization" CssClass="sectionBox edNews_loaderWrapper" runat="server" Visible="False">
			<div class="edNews_loader">
				<div></div>
			</div>
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=CategoryLocalization%></span>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft"><%=_("lblCLTitleResource1", true) %></label>
				<asp:Label ID="lblCatTitle" runat="server" resourcekey="lblCatTitleResource1"></asp:Label>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft"><%=Defaultportallanguage%></label>
				<asp:Label ID="lblDefaultPortalLangugage" runat="server" resourcekey="lblDefaultPortalLangugageResource1"></asp:Label>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft"><%=_("lblLocLangArticleResource1.Text") %></label>
				<asp:Label ID="lblLocalizedLanguages" runat="server" Text="None"></asp:Label>
			</div>
			<div class="edNews_inputGroup">
				<asp:Label ID="lblNotLocalizedLanguagesHelp" runat="server" resourcekey="lblNotLocalizedLanguagesHelp" Text="Not localized languages for this category:" />
				<asp:Label ID="lblNotLocalizedLanguages" runat="server" Text="None" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlCLLanguageSelect.ClientID %>"><%=_("lblCLSelectLanguageResource1.Text") %></label>
				<asp:DropDownList ID="ddlCLLanguageSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCLLanguageSelect_SelectedIndexChanged" resourcekey="ddlCLLanguageSelectResource1"></asp:DropDownList>
			</div>
			<div class="mainActions smallActions">
				<asp:LinkButton ID="lbCLCopyDefaults" resourcekey="lbCLCopyDefaults" CssClass="copy" runat="server" OnClick="lbCLCopyDefaults_Click"><span>Copy default values</span></asp:LinkButton>
				<asp:LinkButton ID="btnDeleteLocalization" resourcekey="btnDeleteLocalization" CssClass="delete" runat="server" OnClick="btnDeleteLocalization_Click"><span>Delete selected locale</span></asp:LinkButton>
			</div>
			<div runat="server" id="aiTranslateOptionsRow" class="edNews_inputGroup" visible="false">
				<label for="<%=ddlTranslateWithOpenAIOptions.ClientID %>" class="edNews_tooltip textLeft" data-tooltip-content="<%=_("AItranslateOptions.Help", true) %>" data-tooltip-position="top-right"><%=_("AItranslateOptions.Text") %></label>
				<asp:DropDownList ID="ddlTranslateWithOpenAIOptions" runat="server">
					<asp:ListItem resourcekey="liAllLanguages" Value="liAllLanguages" Text="All languages" />
					<asp:ListItem resourcekey="liSelectedlanguage" Value="liSelectedlanguage" Text="Selected language" />
					<asp:ListItem resourcekey="liOnlylanguagesWithoutTranslation" Value="liWithoutTranslation" Text="Only languages without translation" />
				</asp:DropDownList>
				<div class="mainActions smallActions noMargin displayInline">
					<asp:LinkButton ID="lbTranslateWithOpenAI" OnClientClick="return openLocalizationPreloader();" runat="server" CssClass="primaryAction" resourcekey="lbTranslateWithAI" Text="Translate with Open AI" OnClick="lbTranslateWithOpenAI_Click" />
				</div>
			</div>
			<div class="edNews_inputGroup inputWidth40">
				<label class="textLeft" for="<%=tbCategoryName.ClientID %>"><%=Categoryname%></label>
				<asp:TextBox ID="tbCLCategoryTitle" CssClass="text" runat="server" MaxLength="200" ValidationGroup="vgCatTitleUpdate" CausesValidation="true" />
				<asp:RequiredFieldValidator CssClass="smallInfo error" ID="rfvCLCategoryTitle" runat="server" ControlToValidate="tbCLCategoryTitle" ErrorMessage="This field is required." ValidationGroup="vgCatTitleUpdate" resourcekey="rfvCategoryNameResource1" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=txtCatLocDescription.ClientID %>"><%=Categorydescription%></label>
				<dnn:TextEditor ID="txtCatLocDescription" runat="server" Height="300" />
			</div>
			<div runat="server" id="pnlCategoryLink" class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categorylink%></span>
				</div>
				<div class="edNews_inputGroup inputWidth100">
					<asp:TextBox ID="tbLocCatURL" runat="server"></asp:TextBox>
					<Portal:URL ID="ctlLocURL" runat="server" ShowNewWindow="False" ShowUsers="False" ShowFiles="False" ShowLog="False" ShowSecure="False" ShowTabs="True" ShowTrack="False" ShowUpLoad="False" ShowUrls="False" ShowDatabase="False" UrlType="U" />
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=SEOOptions%></span>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbQueryLinkLocalization.ClientID %>" data-tooltip-content="<%=_("CategoryURL.Help", true) %>" data-tooltip-position="top-right"><%=_("CategoryURL.Text") %></label>
					<asp:TextBox ID="tbQueryLinkLocalization" runat="server" MaxLength="800" ValidationGroup="vgCreateCat" />
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbQueryLinkLocalizationPreview.ClientID %>" data-tooltip-content="<%=_("CategoryURLPreview.Help", true) %>" data-tooltip-position="top-right"><%=_("CategoryURLPreview.Text") %></label>
					<asp:TextBox ID="tbQueryLinkLocalizationPreview" runat="server" MaxLength="800" ValidationGroup="vgCreateCat" Enabled="False" />
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbTitleTagLocalization.ClientID %>" data-tooltip-content="<%=_("TitleTag.Help", true) %>" data-tooltip-position="top-right"><%=_("TitleTag.Text") %></label>
					<asp:TextBox ID="tbTitleTagLocalization" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceTitleTagLozalizationCount" for="<%=tbTitleTagLocalization.ClientID %>" data-tooltip-content="<%=_("TitleTagCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbMetaDecriptionLocalization.ClientID %>" data-tooltip-content="<%=_("MetaDecription.Help", true) %>" data-tooltip-position="top-right"><%=_("MetaDecription.Text") %></label>
					<asp:TextBox ID="tbMetaDecriptionLocalization" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceMetaDecriptionLocalizationCount" for="<%=tbMetaDecriptionLocalization.ClientID %>" data-tooltip-content="<%=_("MetaDescriptionCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=tbMetaKeywordsLocalization.ClientID %>" data-tooltip-content="<%=_("MetaKeywords.Help", true) %>" data-tooltip-position="top-right"><%=_("MetaKeywords.Text") %></label>
					<asp:TextBox ID="tbMetaKeywordsLocalization" runat="server" MaxLength="255" ValidationGroup="vgCreateCat" />
					<label class="textLeft labelInline edNews_tooltip" id="edsNews__ceMetaKeywordsLocalizationCount" for="<%=tbMetaKeywordsLocalization.ClientID %>" data-tooltip-content="<%=_("MetaKeyWordsCharacterCount.Help", true) %>" data-tooltip-position="top-left"></label>
				</div>
				<div class="edNews_inputGroup inputWidth40">
					<label class="textLeft edNews_tooltip" for="<%=ddlAddRobotsFollowTagLocalization.ClientID %>" data-tooltip-content="<%=_("AddRobotsFollowTag.Help", true) %>" data-tooltip-position="top-right"><%=_("AddRobotsFollowTag.Text") %></label>
					<asp:DropDownList ID="ddlAddRobotsFollowTagLocalization" runat="server">
						<asp:ListItem Value="-1">None</asp:ListItem>
						<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
						<asp:ListItem>INDEX, NOFOLLOW</asp:ListItem>
						<asp:ListItem>NOINDEX, FOLLOW</asp:ListItem>
						<asp:ListItem>NOINDEX, NOFOLLOW</asp:ListItem>
					</asp:DropDownList>
				</div>
			</div>
			<asp:Label ID="lblErrorInfoMsg" runat="server" EnableViewState="false" Visible="false" />
			<div class="mainActions">
				<asp:LinkButton ID="btnAddCoategoryLocalization" CssClass="downSave" runat="server" OnClick="btnAddCoategoryLocalization_Click" CausesValidation="true" ValidationGroup="vgLocCategory" resourcekey="btnAddCoategoryLocalizationResource1">Save category localization</asp:LinkButton>
				<asp:LinkButton ID="btnCloseLocalization" CssClass="cancel" runat="server" OnClick="btnCloseLocalization_Click" Text="Close" resourcekey="btnCloseLocalizationResource1" />
			</div>
		</asp:Panel>
	</div>
</div>

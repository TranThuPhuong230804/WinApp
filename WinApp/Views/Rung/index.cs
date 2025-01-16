using System;
namespace WinApp.Views.Rung
{
    using Vst.Controls;
    using Models;
    class Index : BaseView<DataListViewLayout>
    {
        protected override void RenderCore(ViewContext context)
        {
            base.RenderCore(context);
            context.Title = "Rừng";
            context.TableColumns = new object[] {
                new TableColumn { Name = "ten", Caption = "Tên giống", Width = 150, },
                new TableColumn { Name = "dientich", Caption = "Diện tích", Width = 100, },
            };
            // Nếu không cần tìm kiếm thì xóa đoạn code này
            context.Search = (e, s) => {
                var x = (Rung)e;
                return x.Ten.ToLower().Contains(s);
            };
        }
    }
    class Add : EditView
    {
        protected override void RenderCore(ViewContext context)
        {
            base.RenderCore(context);
            context.Title = " Information";
            context.Editors = new object[] {
                new EditorInfo { Name = "ten", Caption = " Caption of Ten", Layout = 12,   },
                new EditorInfo { Name = "dientich", Caption = " Caption of dientich", Layout = 12,   },
            };
        }
    }
    class Edit : Add
    {
        protected override void OnReady()
        {
            // Thay Ten bằng tên trường muốn thể hiện trên câu hỏi xóa bản ghi
            ShowDeleteAction("ten");
            // Thay EditorName bằng tên trường muốn cấm soạn thảo
            Find("EditorName", c => c.IsEnabled = false);
        }
    }
}

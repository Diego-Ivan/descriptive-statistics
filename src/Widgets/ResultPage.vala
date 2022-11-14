/* ResultPage.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/descriptive_statistics/gtk/result-page.ui")]
public class DescriptiveStatistics.ResultPage : Adw.PreferencesGroup {
    [GtkChild]
    private unowned Gtk.ListBox list_box;

    private Results _result;
    public Results result {
        get {
            return _result;
        }
        set {
            _result = value;
            title = result.title;
            list_box.bind_model (result.operation_results, (i) => {
                var operation = (Operation) i;
                return new Adw.ActionRow () {
                    title = operation.operation,
                    subtitle = operation.result.to_string ()
                };
            });
        }
    }

    public ResultPage (Results result) {
        Object (result: result);
    }

    [GtkCallback]
    private void on_copy_button_clicked () {
        unowned var clipboard = Gdk.Display.get_default ().get_clipboard ();
        clipboard.set_text (result.to_string ());
    }
}

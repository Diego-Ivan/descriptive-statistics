/* DataRow.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[GtkTemplate (ui = "/io/github/diegoivan/descriptive_statistics/gtk/data-row.ui")]
public class DescriptiveStatistics.DataRow : Adw.ActionRow {
    private string? _data;
    public string? data {
        get {
            return _data;
        }
        set {
            _data = value;
            notify_property ("holds-data");

            if (data == null) {
                title = "No Data Is Held";
                return;
            }

            title = "Data Has Been Set";
        }
    }

    public bool holds_data {
        get {
            return data != null;
        }
    }

    construct {
        data = null;
    }

    [GtkCallback]
    private void on_visualize_clicked () {
        var grid = new VisualizationGrid ();
        var builder = new ColumnBuilder ();
        builder.add_text (data);

        grid.populate (builder.build ());
        var win = new Gtk.Window () {
            child = grid,
            transient_for = (Gtk.Window) get_root (),
            modal = true
        };
        win.present ();
    }

    [GtkCallback]
    private void on_clipboard_clicked () {
        read_clipboard.begin ();
    }

    [GtkCallback]
    private void on_clear_clicked () {
        data = null;
    }

    private async void read_clipboard () {
        try {
            data = yield Gdk.Display.get_default ().get_clipboard ().read_text_async (null);
        }
        catch (Error e) {
            critical (e.message);
        }
    }
}

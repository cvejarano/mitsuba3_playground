import marimo

__generated_with = "0.23.6"
app = marimo.App(width="medium")


@app.cell
def _():
    import matplotlib.pyplot as plt
    import mitsuba as mi

    mi.set_variant("scalar_rgb")
    return mi, plt


@app.cell
def _(mi, plt):
    # Render the Cornell box scene
    scene = mi.load_dict(mi.cornell_box())
    image = mi.render(scene, spp=256)
    plt.imshow(image ** (1.0 / 2.2))
    return


@app.cell
def _():
    return


if __name__ == "__main__":
    app.run()
